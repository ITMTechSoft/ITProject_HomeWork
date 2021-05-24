import 'package:flutter/material.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Screens/Home/Customers.dart';
import 'package:it_project_homework/Screens/Home/Orders.dart';
import 'package:it_project_homework/Widgets/ApplicationBars.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';
import 'package:it_project_homework/assets/images/ImgAssets.dart';
import 'package:provider/provider.dart';

import 'Category.dart';
import 'Products.dart';
import 'Services.dart';
import 'Visits.dart';


class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int IntiteStatus = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget HeaderIcon = CircleAvatar(
    radius: 100.0,
    foregroundColor: Colors.red,
    backgroundColor: Colors.white10,
    child: Image.asset(
      ImgAssets.User,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    ),
  );

  Widget ImageTextButton(
      {String HeaderText, String ImageAsset, Function OnTap}) {
    return Container(
      margin: EdgeInsets.all(20),
      child: InkWell(
        onTap: OnTap,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                  radius: 50.0,
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.white10,
                  child: Image.asset(
                    ImageAsset,
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  )),
              Text(
                HeaderText,
                style: TextStyle(
                    color: ArgonColors.text, fontSize: ArgonSize.Header3),
              )
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Scaffold(
        appBar: MainBar(PersonalCase, "home"),
        body: Container(
            margin: EdgeInsets.all(ArgonSize.MainMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                    child: Column(
                  children: [
                    HeaderIcon,
                    Text(
                      "Monzer Alkhiami",
                      style: TextStyle(
                          color: ArgonColors.header,
                          fontSize: ArgonSize.Header),
                    )
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: ImageTextButton(
                            HeaderText: "Customers",
                            ImageAsset: ImgAssets.Customers,
                            OnTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Customers()));
                            })),
                    Expanded(
                        child: ImageTextButton(
                            HeaderText: "Services",
                            ImageAsset: ImgAssets.Services,
                            OnTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Services()));
                            })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: ImageTextButton(
                            HeaderText: "Visits",
                            ImageAsset: ImgAssets.Visits,
                            OnTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Visits()));
                            })),
                    Expanded(
                        child: ImageTextButton(
                            HeaderText: "Products",
                            ImageAsset: ImgAssets.Products,
                            OnTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Products()));
                            })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: ImageTextButton(
                            HeaderText: "Category",
                            ImageAsset: ImgAssets.Bills,
                            OnTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Categories()));
                            })),
                    Expanded(
                        child: ImageTextButton(
                            HeaderText: "Orders",
                            ImageAsset: ImgAssets.Orders,
                            OnTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Orders()));
                            })),
                  ],
                )
              ],
            )));
  }
}
