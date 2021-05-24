import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_project_homework/Models/Categories.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Widgets/ApplicationBars.dart';
import 'package:it_project_homework/Widgets/ErrorPage.dart';
import 'package:it_project_homework/Widgets/Input.dart';
import 'package:it_project_homework/Widgets/LableText.dart';
import 'package:it_project_homework/Widgets/button.dart';
import 'package:it_project_homework/assets/Component/List_Items.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int IntiteStatus = 0;

  Future<List<CategoriesBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<CategoriesBLL> Criteria = await CategoriesBLL.Get_Categories();

    Criteria = new List<CategoriesBLL>();
    Criteria.add(new CategoriesBLL(
        Id: 1,
        Description: "Description Category 1 ",
        Category_Name: "Category 1"));
    Criteria.add(new CategoriesBLL(
        Id: 2,
        Description: "Description 2 ",
        Category_Name: "Category 2"));
    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetCategoriesList(PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return CategoriesList(PersonalCase, snapshot.data[i], () async {
            setState(() {
              PersonalCase.SelectedCategories = snapshot.data[i];
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar("Categories", PersonalCase, () {
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
                      builder: (BuildContext context) => CategoriesEditUpdate(
                        HeaderLable: "New Categories",
                      )));
            }, color: ArgonColors.success),
            AddAction("Edit", Icons.edit, OnTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CategoriesEditUpdate(
                        HeaderLable: "Update Categories",
                        Item: PersonalCase.SelectedCategories,
                      )));
            }, color: ArgonColors.inputSuccess),
            AddAction("Delete", Icons.delete_forever_rounded, OnTap: () async {
              if (PersonalCase.SelectedCategories != null) {
                bool Check = await PersonalCase.SelectedCategories.DeleteEntity();
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
              return GetCategoriesList(PersonalCase, snapshot);
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

class CategoriesEditUpdate extends StatefulWidget {
  String HeaderLable;
  CategoriesBLL Item;

  CategoriesEditUpdate({Key key, this.HeaderLable, this.Item}) : super(key: key);

  @override
  _CategoriesEditUpdateState createState() => _CategoriesEditUpdateState();
}

class _CategoriesEditUpdateState extends State<CategoriesEditUpdate> {
  final TextEditingController Description = new TextEditingController();
  final TextEditingController Category_Name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    if (widget.Item != null) {

      Description.text = widget.Item.Description;
      Category_Name.text = widget.Item.Category_Name;

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

                  widget.Item.Description = Description.text;
                  widget.Item.Category_Name = Category_Name.text;
                  widget.Item.UpdateEntity();
                } else {
                  widget.Item = new CategoriesBLL();
                  widget.Item.Description = Description.text;
                  widget.Item.Category_Name = Category_Name.text;
                  widget.Item.SaveEntity();
                }

                Navigator.pop(context);
              }, color: ArgonColors.inputSuccess),
              AddAction("Cancel", Icons.cancel_presentation, OnTap: () {
                Navigator.pop(context);
              }, color: ArgonColors.warning),
            ],
          ),
          LableTitle("Category Name", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Category_Name,
            Ktype: TextInputType.text,
          ),
          LableTitle("Description", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Description,
            Ktype: TextInputType.text,
          ),
        ]),
      ),
    );
  }
}
