import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:it_project_homework/Preferences/SharedPref.dart';
import 'package:it_project_homework/WebApi/WebServiceApi.dart';

class VisitsBLL {
  //#region Properties
  int Id;
  String Visit_Name;
  int Service_Products_Id;
  int Order_Id;
  DateTime Start_Time;
  DateTime End_Time;
  String Note;

  //#endregion

  VisitsBLL({this.Id, this.Visit_Name, this.Start_Time, this.End_Time}) {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Visit_Name = json['Visit_Name'];
    this.Service_Products_Id = json['Service_Products_Id'];
    this.Order_Id = json['Order_Id'];
    this.Start_Time =
        json['Start_Time'] == null ? null : DateTime.parse(json['Start_Time']);
    this.End_Time =
        json['End_Time'] == null ? null : DateTime.parse(json['End_Time']);
    this.Note = json['Note'];
  }

  VisitsBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Visit_Name = json['Visit_Name'],
        Service_Products_Id = json['Service_Products_Id'],
        Order_Id = json['Order_Id'],
        Start_Time = json['Start_Time'] == null
            ? null
            : DateTime.parse(json['Start_Time']),
        End_Time =
            json['End_Time'] == null ? null : DateTime.parse(json['End_Time']),
        Note = json['Note'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Visit_Name': Visit_Name,
        'Service_Products_Id': Service_Products_Id,
        'Order_Id': Order_Id,
        'Start_Time': Start_Time,
        'End_Time': End_Time,
        'Note': Note,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'Visit_Name': Visit_Name,
        'Service_Products_Id': Service_Products_Id.toString(),
        'Order_Id': Order_Id.toString(),
        'Start_Time': Start_Time.toString(),
        'End_Time': End_Time.toString(),
        'Note': Note,
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<VisitsBLL>> Get_Visits() async {
    List<VisitsBLL> ItemList;
    try {
      var response =
          await http.get(SharedPref.GetWebApiUrl(WebApiMethod.Get_Visits));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => VisitsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> SaveEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(WebApiMethod.Set_CreateVisits);

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
      final String url = SharedPref.GetWebApiUrl(WebApiMethod.Set_UpdateVisits);

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
      final String url = SharedPref.GetWebApiUrl(WebApiMethod.Set_DeleteVisits);

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
