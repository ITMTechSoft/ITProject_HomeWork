import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:it_project_homework/Preferences/SharedPref.dart';
import 'package:it_project_homework/WebApi/WebServiceApi.dart';

class AppUsersBLL {
  //#region Properties
  int Id;
  String Full_Name;
  String UserName;
  String Password;
  bool ValidUser =false;
  String LoginMessage;

  //#endregion



  AppUsersBLL({this.UserName,this.Password});

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Full_Name = json['Full_Name'];
    this.UserName = json['UserName'];
    this.Password = json['Password'];

  }

  AppUsersBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        Full_Name = json['Full_Name'],
        UserName = json['UserName'],
        Password = json['Password'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'Full_Name': Full_Name,
    'UserName': UserName,
    'Password': Password,

  };

  Map<String, String> toPost() => {


    'Id': Id.toString(),
    'Full_Name': Full_Name,
    'UserName': UserName,
    'Password': Password,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<AppUsersBLL>> Get_AppUsers(
      int Id) async {
    List<AppUsersBLL> ItemList;
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_AppUsers) +
              "?User_Id=" +
              Id.toString());

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => AppUsersBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<void> login() async {
    try {
      final String url =
      SharedPref.GetWebApiUrl(WebApiMethod.CheckUserConnection);


      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        this.LoadFromJson(json.decode(response.body));
      }else
      {
        print(response.statusCode.toString() + ": " +response.toString());
      }
    } catch (Excpetion) {
      print(Excpetion);
    }
  }

  Sign_In(String UserName, String Password) async {
    AppUsersBLL CheckUserLogin = new AppUsersBLL(UserName: UserName,Password: Password);
    Map data = {'User': CheckUserLogin};
    var jsonResponse = null;
    var response = await http.post(
        SharedPref.GetWebApiUrl(WebApiMethod.CheckUserConnection),
        body: data);
    if (response.statusCode == 200) {
      CheckUserLogin = AppUsersBLL.fromJson(json.decode(response.body));
    }
    return CheckUserLogin;
  }

  Logout() {
    this.ValidUser = false;
  }
//#endregion



}

