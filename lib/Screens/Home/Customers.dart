import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_project_homework/Models/Customer.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Widgets/ApplicationBars.dart';
import 'package:it_project_homework/Widgets/ErrorPage.dart';
import 'package:it_project_homework/Widgets/Input.dart';
import 'package:it_project_homework/Widgets/LableText.dart';
import 'package:it_project_homework/Widgets/button.dart';
import 'package:it_project_homework/assets/Component/List_Items.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';
import 'package:provider/provider.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  int IntiteStatus = 0;

  Future<List<CustomerBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<CustomerBLL> Criteria = await CustomerBLL.Get_Customer();

    Criteria = new List<CustomerBLL>();
    Criteria.add(new CustomerBLL(
        Id: 1,
        Full_Name: "Monzer Alkhiami",
        Email: "Monzer.al.khiami@gmail.com",
        Phone: "05071892614"));
    Criteria.add(new CustomerBLL(
        Id: 2,
        Full_Name: "Amr Alkhiami",
        Email: "Amr.al.khiami@gmail.com",
        Phone: "05071892614"));
    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetCustomerList(PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return CustomerList(PersonalCase, snapshot.data[i], () async {
            setState(() {
              PersonalCase.SelectedCustomer = snapshot.data[i];
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar("Customers", PersonalCase, () {
        Navigator.pop(context);
      }),
      body: ListView(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AddAction("New", Icons.add_box_rounded, OnTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CustomerEditUpdate(
                            HeaderLable: "New Customer",
                          )));
            }, color: ArgonColors.success),
            AddAction("Edit", Icons.edit, OnTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CustomerEditUpdate(
                            HeaderLable: "Update Customer",
                            Item: PersonalCase.SelectedCustomer,
                          )));
            }, color: ArgonColors.inputSuccess),
            AddAction("Delete", Icons.delete_forever_rounded, OnTap: () async {
              if (PersonalCase.SelectedCustomer != null) {
                bool Check = await PersonalCase.SelectedCustomer.DeleteEntity();
                if(Check)
                  setState(() {
                    
                  });
              }
            }, color: ArgonColors.warning),
          ],
        ),
        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GetCustomerList(PersonalCase, snapshot);
            } else if (IntiteStatus == 0)
              return Center(child: CircularProgressIndicator());
            else
              return ErrorPage(
                  ActionName: "Loading",
                  MessageError: "Error While Loading Data",
                  DetailError: "Invalid Network Connection ....");
          },
        )
      ]),
    );
  }
}

class CustomerEditUpdate extends StatefulWidget {
  String HeaderLable;
  CustomerBLL Item;

  CustomerEditUpdate({Key key, this.HeaderLable, this.Item}) : super(key: key);

  @override
  _CustomerEditUpdateState createState() => _CustomerEditUpdateState();
}

class _CustomerEditUpdateState extends State<CustomerEditUpdate> {
  final TextEditingController Full_NameController = new TextEditingController();
  final TextEditingController EmailController = new TextEditingController();
  final TextEditingController PhoneController = new TextEditingController();
  final TextEditingController CountryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    if (widget.Item != null) {
      Full_NameController.text = widget.Item.Full_Name;
      EmailController.text = widget.Item.Email;
      PhoneController.text = widget.Item.Phone;
      CountryController.text = widget.Item.Country;
    }

    return Scaffold(
      appBar: DetailBar(widget.HeaderLable, PersonalCase, () {
        Navigator.pop(context);
      }),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddAction("Save", Icons.save, OnTap: () async {
                if (widget.Item != null) {
                  widget.Item.Full_Name = Full_NameController.text;
                  widget.Item.Email = EmailController.text;
                  widget.Item.Phone = PhoneController.text;
                  widget.Item.Country = CountryController.text;
                  widget.Item.UpdateEntity();
                } else {
                  widget.Item = new CustomerBLL();
                  widget.Item.Full_Name = Full_NameController.text;
                  widget.Item.Email = EmailController.text;
                  widget.Item.Phone = PhoneController.text;
                  widget.Item.Country = CountryController.text;
                  widget.Item.SaveEntity();
                }

                Navigator.pop(context);
              }, color: ArgonColors.inputSuccess),
              AddAction("Cancel", Icons.cancel_presentation, OnTap: () {
                Navigator.pop(context);
              }, color: ArgonColors.warning),
            ],
          ),
          LableTitle("Full Name", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Full_NameController,
            Ktype: TextInputType.text,
          ),
          LableTitle("Email", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: EmailController,
            Ktype: TextInputType.text,
          ),
          LableTitle("Phone", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: PhoneController,
            Ktype: TextInputType.text,
          ),
          LableTitle("Country", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: CountryController,
            Ktype: TextInputType.text,
          )
        ]),
      ),
    );
  }
}
