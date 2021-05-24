import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:it_project_homework/Preferences/SharedPref.dart';
import 'package:it_project_homework/WebApi/WebServiceApi.dart';


class CustomerBLL {
  //#region Properties
  int Id;
  String Full_Name;
  String Email;
  String Phone;
  String Country;

  //#endregion

  CustomerBLL({this.Id,this.Full_Name,this.Email,this.Phone}) {

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Full_Name = json['Full_Name'];
    this.Email = json['Email'];
    this.Phone = json['Phone'];
    this.Country = json['Country'];

  }

  CustomerBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        Full_Name = json['Full_Name'],
        Email = json['Email'],
        Phone = json['Phone'],
        Country = json['Country'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'Full_Name': Full_Name,
    'Email': Email,
    'Phone': Phone,
    'Country': Country,

  };

  Map<String, String> toPost() => {


    'Id': Id.toString(),
    'Full_Name': Full_Name,
    'Email': Email,
    'Phone': Phone,
    'Country': Country,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<CustomerBLL>> Get_Customer(
      {int Customer_Id}) async {
    List<CustomerBLL> ItemList;
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_Customers));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => CustomerBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> SaveEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_CreateCustomer);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> UpdateEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_UpdateCustomer);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> DeleteEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_DeleteCustomer);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }
//#endregion



}

