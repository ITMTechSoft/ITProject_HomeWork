import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:it_project_homework/Preferences/SharedPref.dart';
import 'package:it_project_homework/WebApi/WebServiceApi.dart';

class CategoriesBLL {
  //#region Properties
  int Id;
  String Category_Name;
  String Description;

  //#endregion

  CategoriesBLL({this.Id,this.Category_Name,this.Description}) {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Category_Name = json['Category_Name'];
    this.Description = json['Description'];
  }

  CategoriesBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Category_Name = json['Category_Name'],
        Description = json['Description'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Category_Name': Category_Name,
        'Description': Description,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'Category_Name': Category_Name,
        'Description': Description,
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<CategoriesBLL>> Get_Categories() async {
    List<CategoriesBLL> ItemList;
    try {
      var response =
          await http.get(SharedPref.GetWebApiUrl(WebApiMethod.Get_Categories));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => CategoriesBLL.fromJson(i))
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
          SharedPref.GetWebApiUrl(WebApiMethod.Set_CreateCategories);

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
          SharedPref.GetWebApiUrl(WebApiMethod.Set_UpdateCategories);

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
          SharedPref.GetWebApiUrl(WebApiMethod.Set_DeleteCategories);

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
