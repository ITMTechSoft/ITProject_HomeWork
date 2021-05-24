import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:it_project_homework/Preferences/SetupApplication.dart';
import 'package:it_project_homework/Preferences/SharedPref.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Widgets/Input.dart';
import 'package:it_project_homework/Widgets/button.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';
import 'package:it_project_homework/assets/images/ImgAssets.dart';
import 'package:provider/provider.dart';

import 'SignUpPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  var errorMsg;
  final TextEditingController UserNameController = new TextEditingController();
  final TextEditingController PasswordController = new TextEditingController();

  //#region  SetupConfig
  SetupConfig(context) => TextButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SetupApplication()));
        },
        label: Text(
          'Setting',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
      );

  //#endregion SetupConfig

  LoginFunction(PersonalProvider PersonalCase) => () async {
        print("Login pressed");
        setState(() {
          _isLoading = true;
        });

        PersonalCase.GetCurrentUser().UserName = UserNameController.text;
        PersonalCase.GetCurrentUser().Password = PasswordController.text;
        await PersonalCase.Login();

        setState(() {
          _isLoading = false;
        });
        if (!PersonalCase.GetCurrentUser().ValidUser) {
          errorMsg = PersonalCase.GetCurrentUser().LoginMessage;
          print(
              "The error message is: ${PersonalCase.GetCurrentUser().LoginMessage}");
        }
      };

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    UserNameController.text = SharedPref.UserName;
    PasswordController.text = SharedPref.UserPassword;

    //#region  Form Components

    Widget HeaderIcon = CircleAvatar(
      radius: 100.0,
      foregroundColor: Colors.red,
      backgroundColor: Colors.white10,
      child: Image.asset(
        ImgAssets.QualityIcon,
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
    );

    //#endregion
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Login",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[SetupConfig(context)],
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  HeaderIcon,
                  SizedBox(height: 30.0),
                  Standard_Input(
                    prefixIcon: Icon(Icons.person),
                    controller: UserNameController,
                  ),
                  SizedBox(height: 30.0),
                  Standard_Input(
                      prefixIcon: Icon(Icons.lock),
                      controller: PasswordController,
                      placeholder:
                          "Password"),
                  SizedBox(height: 30),
                  StretchableButton(
                    buttonColor: ArgonColors.primary,
                    children: [
                      Text("Sign In", style: TextStyle(color: Colors.white))
                    ],
                    onPressed: LoginFunction(PersonalCase),
                  ),
                  StretchableButton(
                    buttonColor: ArgonColors.success,
                    children: [
                      Text("Sign Up", style: TextStyle(color: Colors.white))
                    ],
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignUpPage()));
                    },
                  ),
                  errorMsg == null
                      ? Container()
                      : Text(
                          "${errorMsg}",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
