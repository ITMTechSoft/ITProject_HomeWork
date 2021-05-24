import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_project_homework/Models/Products.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Widgets/ApplicationBars.dart';
import 'package:it_project_homework/Widgets/ErrorPage.dart';
import 'package:it_project_homework/Widgets/Input.dart';
import 'package:it_project_homework/Widgets/LableText.dart';
import 'package:it_project_homework/Widgets/button.dart';
import 'package:it_project_homework/assets/Component/List_Items.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  int IntiteStatus = 0;

  Future<List<ProductsBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<ProductsBLL> Criteria = await ProductsBLL.Get_Products();

    Criteria = new List<ProductsBLL>();
    Criteria.add(new ProductsBLL(
        Id: 1,
        Product_Name: "Product 1 ",
        Category_Name: "TShirt",
        Price: 25.5));
    Criteria.add(new ProductsBLL(
        Id: 2,
        Product_Name: "Product 2 ",
        Category_Name: "Computers",
        Price: 2500));
    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetServiceList(PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return ProductList(PersonalCase, snapshot.data[i], () async {
            setState(() {
              PersonalCase.SelectedProduct = snapshot.data[i];
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar("Products", PersonalCase, () {
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
                      builder: (BuildContext context) => ServiceEditUpdate(
                        HeaderLable: "New Service",
                      )));
            }, color: ArgonColors.success),
            AddAction("Edit", Icons.edit, OnTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ServiceEditUpdate(
                        HeaderLable: "Update Service",
                        Item: PersonalCase.SelectedProduct,
                      )));
            }, color: ArgonColors.inputSuccess),
            AddAction("Delete", Icons.delete_forever_rounded, OnTap: () async {
              if (PersonalCase.SelectedProduct != null) {
                bool Check = await PersonalCase.SelectedProduct.DeleteEntity();
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
              return GetServiceList(PersonalCase, snapshot);
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

class ServiceEditUpdate extends StatefulWidget {
  String HeaderLable;
  ProductsBLL Item;

  ServiceEditUpdate({Key key, this.HeaderLable, this.Item}) : super(key: key);

  @override
  _ServiceEditUpdateState createState() => _ServiceEditUpdateState();
}

class _ServiceEditUpdateState extends State<ServiceEditUpdate> {
  final TextEditingController Product_Name = new TextEditingController();
  final TextEditingController Description = new TextEditingController();
  final TextEditingController Category_Name = new TextEditingController();
  final TextEditingController Price = new TextEditingController();
  final TextEditingController Amount = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    if (widget.Item != null) {
      Product_Name.text = widget.Item.Product_Name;
      Description.text = widget.Item.Description;
      Category_Name.text = widget.Item.Category_Name;
      Price.text = widget.Item.Price.toString();
      Amount.text = widget.Item.Amount.toString();
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
                  widget.Item.Product_Name = Product_Name.text;
                  widget.Item.Description = Description.text;
                  widget.Item.Category_Name = Category_Name.text;
                  widget.Item.Price = double.parse(Price.text);
                  widget.Item.Amount = int.parse(Description.text);
                  widget.Item.IsService = false;
                  widget.Item.UpdateEntity();
                } else {
                  widget.Item = new ProductsBLL();
                  widget.Item.Product_Name = Product_Name.text;
                  widget.Item.Description = Description.text;
                  widget.Item.Category_Name = Category_Name.text;
                  widget.Item.Price = double.parse(Price.text);
                  widget.Item.Amount = int.parse(Description.text);
                  widget.Item.IsService = false;
                  widget.Item.SaveEntity();
                }

                Navigator.pop(context);
              }, color: ArgonColors.inputSuccess),
              AddAction("Cancel", Icons.cancel_presentation, OnTap: () {
                Navigator.pop(context);
              }, color: ArgonColors.warning),
            ],
          ),
          LableTitle("Product Name", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Product_Name,
            Ktype: TextInputType.text,
          ),
          LableTitle("Description", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Description,
            Ktype: TextInputType.text,
          ),
          LableTitle("Category Name", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Category_Name,
            Ktype: TextInputType.text,
          ),
          LableTitle("Amount", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.confirmation_number),
            controller: Amount,
            Ktype: TextInputType.number,
          ),
          LableTitle("Price", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.confirmation_number),
            controller: Price,
            Ktype: TextInputType.number,
          )
        ]),
      ),
    );
  }
}
