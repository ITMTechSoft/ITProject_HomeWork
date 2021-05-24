import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:it_project_homework/Preferences/SharedPref.dart';
import 'package:it_project_homework/WebApi/WebServiceApi.dart';

class OrdersBLL {
  //#region Properties
  int Id;
  int AppUser_Id;
  int Customer_Id;
  DateTime Order_Date;
  double Total_Price;
  String Note;
  String Full_Name;

  //#endregion

  OrdersBLL({this.Id,this.Full_Name,this.Order_Date,this.Total_Price,this.Note}) {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.AppUser_Id = json['AppUser_Id'];
    this.Customer_Id = json['Customer_Id'];
    this.Order_Date =
        json['Order_Date'] == null ? null : DateTime.parse(json['Order_Date']);
    this.Total_Price = json['Total_Price'];
    this.Note = json['Note'];
    this.Full_Name = json['Full_Name'];
  }

  OrdersBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        AppUser_Id = json['AppUser_Id'],
        Customer_Id = json['Customer_Id'],
        Order_Date = json['Order_Date'] == null
            ? null
            : DateTime.parse(json['Order_Date']),
        Total_Price = json['Total_Price'],
        Note = json['Note'],
        Full_Name = json['Full_Name'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'AppUser_Id': AppUser_Id,
        'Customer_Id': Customer_Id,
        'Order_Date': Order_Date,
        'Total_Price': Total_Price,
        'Note': Note,
        'Full_Name': Full_Name,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'AppUser_Id': AppUser_Id.toString(),
        'Customer_Id': Customer_Id.toString(),
        'Order_Date': Order_Date.toString(),
        'Total_Price': Total_Price.toString(),
        'Note': Note,
        'Full_Name': Full_Name,
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<OrdersBLL>> Get_Orders() async {
    List<OrdersBLL> ItemList;
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_Orders));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => OrdersBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> SaveEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(WebApiMethod.Set_CreateOrders);

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
      final String url = SharedPref.GetWebApiUrl(WebApiMethod.Set_UpdateOrders);

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
      final String url = SharedPref.GetWebApiUrl(WebApiMethod.Set_DeleteOrders);

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
