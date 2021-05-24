import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Utility/constants.dart';
import 'package:it_project_homework/Widgets/LableText.dart';
import 'package:it_project_homework/Widgets/RoundedButtons.dart';
import 'package:it_project_homework/assets/Resources/StaticLable.dart';
import 'package:provider/provider.dart';

import 'SharedPref.dart';

class SetupApplication extends StatefulWidget {
  @override
  _SetupApplicationState createState() => _SetupApplicationState();
}

class _SetupApplicationState extends State<SetupApplication> {
  bool _EditServerIp = false;
  bool _EditServerPort = false;
  bool _EditUserName = false;
  bool _EditPassword = false;

  TextEditingController _InputController;

  DisableInput() {
    _EditServerIp = false;
    _EditServerPort = false;
    _EditUserName = false;
    _EditPassword = false;
  }


  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    //#region Input


    Widget ServerIps = _EditServerIp
        ? TextField(
            controller: _InputController,
            // obscureText: true,
            onChanged: (values) {},

            onSubmitted: (values) {
              setState(() {
                SharedPref.ServerIp = values;
                _EditServerIp = false;
              });
            },
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: TextFieldDecoration.copyWith(
              hintText: StaticLable.ServerIp,
              labelText: StaticLable.ServerIp,
            ),
          )
        : settingTiles(
            context: context,
            icon: FontAwesomeIcons.server,
            onTap: () {
              setState(() {
                DisableInput();
                _EditServerIp = true;
              });
            },
            subtitle: SharedPref.ServerIp,
            title: StaticLable.ServerIp);
    Widget ServerPorts = _EditServerPort
        ? TextField(
            controller: _InputController,
            // obscureText: true,
            onChanged: (values) {},

            onSubmitted: (values) {
              setState(() {
                SharedPref.ServerPort = values;
                _EditServerPort = false;
              });
            },
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: TextFieldDecoration.copyWith(
              hintText: SharedPref.ServerPort,
              labelText: StaticLable.ServerPort,
            ),
          )
        : settingTiles(
            context: context,
            icon: FontAwesomeIcons.megaport,
            onTap: () {
              setState(() {
                DisableInput();
                _EditServerPort = true;
              });
            },
            subtitle: SharedPref.ServerPort,
            title: StaticLable.ServerPort);

    Widget EditUsers = _EditUserName
        ? TextField(
            controller: _InputController,
            // obscureText: true,
            onChanged: (values) {},

            onSubmitted: (values) {
              setState(() {
                SharedPref.UserName = values;
                _EditUserName = false;
              });
            },
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: TextFieldDecoration.copyWith(
              hintText: SharedPref.UserName,
              labelText: StaticLable.UserName,
            ),
          )
        : settingTiles(
            context: context,
            icon: FontAwesomeIcons.user,
            onTap: () {
              setState(() {
                DisableInput();
                _EditUserName = true;
              });
            },
            subtitle: SharedPref.UserName,
            title: StaticLable.UserName);

    Widget EditPassword = _EditPassword
        ? TextField(
            controller: _InputController,
            // obscureText: true,
            onChanged: (values) {},

            onSubmitted: (values) {
              setState(() {
                SharedPref.UserPassword = values;
                _EditPassword = false;
              });
            },
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: TextFieldDecoration.copyWith(
              hintText: SharedPref.UserPassword,
              labelText: StaticLable.UserPassword,
            ),
          )
        : settingTiles(
            context: context,
            icon: FontAwesomeIcons.passport,
            onTap: () {
              setState(() {
                DisableInput();
                _EditPassword = true;
              });
            },
            subtitle: SharedPref.UserPassword,
            title: StaticLable.UserPassword);

    //#endregion
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
            "Configuration"),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20),
                      child: HeaderTitle(StaticLable.SystemVersion)),
                  ServerIps,
                  ServerPorts,
                  EditUsers,
                  EditPassword,
                  ReusableRoundedButton(
                    child: Text(
                      StaticLable.Save,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      await PersonalCase.SetupAndLogin();

                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.redAccent,
                    height: 40,
                  )
                ],
              )),
        ),
      ),
    );
  }

  InkWell settingTiles(
      {BuildContext context,
      Function onTap,
      String title,
      String subtitle,
      IconData icon}) {
    return InkWell(
      splashColor: Colors.red[100],
      onTap: onTap,
      child: ListTile(
        trailing: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold
              // fontFamily: 'Ninto',
              ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
