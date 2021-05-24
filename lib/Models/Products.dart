import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:it_project_homework/Preferences/SharedPref.dart';
import 'package:it_project_homework/WebApi/WebServiceApi.dart';

class ProductsBLL {
  //#region Properties
  int Id;
  int AppUser_Id;
  bool IsService;
  String Product_Name;
  String Description;
  int Category_Id;
  double Price;
  int Amount;
  String Full_Name;
  String Category_Name;

  //#endregion

  ProductsBLL({this.Id, this.Product_Name, this.Category_Name, this.Price}) {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.AppUser_Id = json['AppUser_Id'];
    this.IsService = json['IsService'];
    this.Product_Name = json['Product_Name'];
    this.Description = json['Description'];
    this.Category_Id = json['Category_Id'];
    this.Price = json['Price'];
    this.Amount = json['Amount'];
    this.Full_Name = json['Full_Name'];
    this.Category_Name = json['Category_Name'];
  }

  ProductsBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        AppUser_Id = json['AppUser_Id'],
        IsService = json['IsService'],
        Product_Name = json['Product_Name'],
        Description = json['Description'],
        Category_Id = json['Category_Id'],
        Price = json['Price'],
        Amount = json['Amount'],
        Full_Name = json['Full_Name'],
        Category_Name = json['Category_Name'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'AppUser_Id': AppUser_Id,
        'IsService': IsService,
        'Product_Name': Product_Name,
        'Description': Description,
        'Category_Id': Category_Id,
        'Price': Price,
        'Amount': Amount,
        'Full_Name': Full_Name,
        'Category_Name': Category_Name,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'AppUser_Id': AppUser_Id.toString(),
        'IsService': IsService.toString(),
        'Product_Name': Product_Name,
        'Description': Description,
        'Category_Id': Category_Id.toString(),
        'Price': Price.toString(),
        'Amount': Amount.toString(),
        'Full_Name': Full_Name,
        'Category_Name': Category_Name,
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<ProductsBLL>> Get_Products() async {
    List<ProductsBLL> ItemList;
    try {
      var response =
          await http.get(SharedPref.GetWebApiUrl(WebApiMethod.Get_Products));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => ProductsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> SaveEntity() async {
    try {
      final String url =
          SharedPref.GetWebApiUrl(WebApiMethod.Set_CreateProducts);

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
      final String url =
          SharedPref.GetWebApiUrl(WebApiMethod.Set_UpdateProducts);

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
      final String url =
          SharedPref.GetWebApiUrl(WebApiMethod.Set_DeleteProducts);

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
