import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_project_homework/Models/Visits.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Widgets/ApplicationBars.dart';
import 'package:it_project_homework/Widgets/ErrorPage.dart';
import 'package:it_project_homework/Widgets/Input.dart';
import 'package:it_project_homework/Widgets/LableText.dart';
import 'package:it_project_homework/Widgets/button.dart';
import 'package:it_project_homework/assets/Component/List_Items.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';
import 'package:provider/provider.dart';

class Visits extends StatefulWidget {
  @override
  _VisitsState createState() => _VisitsState();
}

class _VisitsState extends State<Visits> {
  int IntiteStatus = 0;

  Future<List<VisitsBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<VisitsBLL> Criteria = await VisitsBLL.Get_Visits();

    Criteria = new List<VisitsBLL>();
    Criteria.add(new VisitsBLL(
        Id: 1,
        Visit_Name: "Visit 1 ",
        Start_Time: DateTime.now(),
        End_Time: DateTime.now()));
    Criteria.add(new VisitsBLL(
        Id: 2,
        Visit_Name: "Visit 2 ",
        Start_Time: DateTime.now(),
        End_Time: DateTime.now()));
    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetVisitList(PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return VisitList(PersonalCase, snapshot.data[i], () async {
            setState(() {
              PersonalCase.SelectedVisit = snapshot.data[i];
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar("Visits", PersonalCase, () {
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
                      builder: (BuildContext context) => VisitEditUpdate(
                        HeaderLable: "New Visit",
                      )));
            }, color: ArgonColors.success),
            AddAction("Edit", Icons.edit, OnTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => VisitEditUpdate(
                        HeaderLable: "Update Visit",
                        Item: PersonalCase.SelectedVisit,
                      )));
            }, color: ArgonColors.inputSuccess),
            AddAction("Delete", Icons.delete_forever_rounded, OnTap: () async {
              if (PersonalCase.SelectedVisit != null) {
                bool Check = await PersonalCase.SelectedVisit.DeleteEntity();
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
              return GetVisitList(PersonalCase, snapshot);
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

class VisitEditUpdate extends StatefulWidget {
  String HeaderLable;
  VisitsBLL Item;

  VisitEditUpdate({Key key, this.HeaderLable, this.Item}) : super(key: key);

  @override
  _VisitEditUpdateState createState() => _VisitEditUpdateState();
}

class _VisitEditUpdateState extends State<VisitEditUpdate> {
  final TextEditingController Visit_Name = new TextEditingController();
  final TextEditingController Note = new TextEditingController();
  final TextEditingController Start_Time = new TextEditingController();
  final TextEditingController End_Time = new TextEditingController();
  final TextEditingController Order = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    if (widget.Item != null) {
      Visit_Name.text = widget.Item.Visit_Name;
      Note.text = widget.Item.Note;
      Start_Time.text = widget.Item.Start_Time.toString();
      End_Time.text = widget.Item.End_Time.toString();
      Order.text = widget.Item.Order_Id.toString();
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
                  widget.Item.Visit_Name = Visit_Name.text;
                  widget.Item.Note = Note.text;
                  widget.Item.Start_Time = DateTime.parse(Start_Time.text);
                  widget.Item.End_Time = DateTime.parse(End_Time.text);
                  widget.Item.Order_Id = int.parse(Order.text);
                  widget.Item.UpdateEntity();
                } else {
                  widget.Item = new VisitsBLL();
                  widget.Item.Visit_Name = Visit_Name.text;
                  widget.Item.Note = Note.text;
                  widget.Item.Start_Time = DateTime.parse(Start_Time.text);
                  widget.Item.End_Time = DateTime.parse(End_Time.text);
                  widget.Item.Order_Id = int.parse(Order.text);
                  widget.Item.SaveEntity();
                }

                Navigator.pop(context);
              }, color: ArgonColors.inputSuccess),
              AddAction("Cancel", Icons.cancel_presentation, OnTap: () {
                Navigator.pop(context);
              }, color: ArgonColors.warning),
            ],
          ),
          LableTitle("Visit Name", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Visit_Name,
            Ktype: TextInputType.text,
          ),
          LableTitle("Note", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Note,
            Ktype: TextInputType.text,
          ),
          LableTitle("Category Name", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.text_format),
            controller: Start_Time,
            Ktype: TextInputType.text,
          ),
          LableTitle("Order", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.confirmation_number),
            controller: Order,
            Ktype: TextInputType.number,
          ),
          LableTitle("End_Time", color: ArgonColors.Title),
          Standard_Input(
            prefixIcon: Icon(Icons.confirmation_number),
            controller: End_Time,
            Ktype: TextInputType.number,
          )
        ]),
      ),
    );
  }
}
