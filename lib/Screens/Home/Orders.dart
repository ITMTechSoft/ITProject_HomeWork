import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_project_homework/Models/Orders.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Widgets/ApplicationBars.dart';
import 'package:it_project_homework/Widgets/ErrorPage.dart';
import 'package:it_project_homework/Widgets/Input.dart';
import 'package:it_project_homework/Widgets/LableText.dart';
import 'package:it_project_homework/Widgets/button.dart';
import 'package:it_project_homework/assets/Component/List_Items.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int IntiteStatus = 0;

  Future<List<OrdersBLL>> LoadingOpenPage(PersonalProvider PersonalCase) async {
    List<OrdersBLL> Criteria = await OrdersBLL.Get_Orders();

    Criteria = new List<OrdersBLL>();
    Criteria.add(new OrdersBLL(
        Id: 1,
        Full_Name: "Customer 1 ",
        Note: "Order Note 1",
        Order_Date: DateTime.now(),
        Total_Price: 125.25));
    Criteria.add(new OrdersBLL(
        Id: 2,
        Full_Name: "Order 2 ",
        Note: "Order Note 2",
        Order_Date: DateTime.now(),
        Total_Price: 205.25));
    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetOrderList(PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
            return OrderList(PersonalCase, snapshot.data[i], () async {
            setState(() {
              PersonalCase.SelectedOrder = snapshot.data[i];
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar("Orders", PersonalCase, () {
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
                      builder: (BuildContext context) => OrderEditUpdate(
                            HeaderLable: "New Order",
                          )));
            }, color: ArgonColors.success),
            AddAction("Edit", Icons.edit, OnTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OrderEditUpdate(
                            HeaderLable: "Update Order",
                            Item: PersonalCase.SelectedOrder,
                          )));
            }, color: ArgonColors.inputSuccess),
            AddAction("Delete", Icons.delete_forever_rounded, OnTap: () async {
              if (PersonalCase.SelectedOrder != null) {
                bool Check = await PersonalCase.SelectedOrder.DeleteEntity();
                if (Check) setState(() {});
              }
            }, color: ArgonColors.warning),
          ],
        ),
        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GetOrderList(PersonalCase, snapshot);
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

class OrderEditUpdate extends StatefulWidget {
  String HeaderLable;
  OrdersBLL Item;

  OrderEditUpdate({Key key, this.HeaderLable, this.Item}) : super(key: key);

  @override
  _OrderEditUpdateState createState() => _OrderEditUpdateState();
}

class _OrderEditUpdateState extends State<OrderEditUpdate> {
  final TextEditingController Full_Name = new TextEditingController();
  final TextEditingController Note = new TextEditingController();
  final TextEditingController Order_Date = new TextEditingController();
  final TextEditingController  Total_Price = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    if (widget.Item != null) {
      Full_Name.text = widget.Item.Full_Name;
      Note.text = widget.Item.Note;
      Order_Date.text = widget.Item.Order_Date.toString();
       Total_Price.text = widget.Item. Total_Price.toString();

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
                  widget.Item.Full_Name = Full_Name.text;
                  widget.Item.Note = Note.text;
                  widget.Item.Order_Date = DateTime.parse(Order_Date.text);
                  widget.Item. Total_Price = double.parse( Total_Price.text);

                  widget.Item.UpdateEntity();
                } else {
                  widget.Item = new OrdersBLL();
                  widget.Item.Full_Name = Full_Name.text;
                  widget.Item.Note = Note.text;
                  widget.Item.Order_Date = DateTime.parse(Order_Date.text);
                  widget.Item. Total_Price = double.parse( Total_Price.text);
                  widget.Item.SaveEntity();
                }

                Navigator.pop(context);
              }, color: ArgonColors.inputSuccess),
              AddAction("Cancel", Icons.cancel_presentation, OnTap: () {
                Navigator.pop(context);
              }, color: ArgonColors.warning),
            ],
          ),
          LableTitle("Customer Name", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Full_Name,
            Ktype: TextInputType.text,
          ),
          LableTitle("Order Note", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Note,
            Ktype: TextInputType.text,
          ),
          LableTitle("Order Date", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.date_range),
            controller: Order_Date,
            Ktype: TextInputType.text,
          ),
          LableTitle(" Total_Price", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.confirmation_number),
            controller:  Total_Price,
            Ktype: TextInputType.number,
          )
        ]),
      ),
    );
  }
}
