import 'package:flutter/foundation.dart';
import 'package:it_project_homework/Models/AppUsers.dart';
import 'package:it_project_homework/Models/Categories.dart';
import 'package:it_project_homework/Models/Customer.dart';
import 'package:it_project_homework/Models/Orders.dart';
import 'package:it_project_homework/Models/Products.dart';
import 'package:it_project_homework/Models/Visits.dart';
import 'package:it_project_homework/Preferences/SharedPref.dart';

class PersonalProvider with ChangeNotifier {
  AppUsersBLL _CurrentUser;
  SharedPref _UserPref;
  bool IsLoading=false;

  CustomerBLL SelectedCustomer;
  ProductsBLL SelectedProduct;
  VisitsBLL SelectedVisit;
  OrdersBLL SelectedOrder;
  CategoriesBLL SelectedCategories;

  PersonalProvider() {
    _CurrentUser = new AppUsersBLL();
    _UserPref = new SharedPref();

  }

  AppUsersBLL GetCurrentUser() {
    return _CurrentUser;
  }

  Future<bool> loadSharedPrefs() async {
    try {
      IsLoading =true;
      bool Status = await _UserPref.initiateAppPrefernce();
      if (Status) {
        _CurrentUser.UserName = SharedPref.UserName;
        _CurrentUser.Password = SharedPref.UserPassword;
        await _CurrentUser.login();


        IsLoading = false;
      }
      return Status;
    } catch (Excepetion) {
      print('When Try Loading loadSharedPrefs:' + Excepetion);
    }
    return false;
  }

  Login() async {
    await _CurrentUser.login();
    notifyListeners();
  }

  SetupAndLogin() async {
    await SharedPref.SetupAndSave();
    _CurrentUser.UserName = SharedPref.UserName;
    _CurrentUser.Password = SharedPref.UserPassword;
    // await _CurrentUser.login();
    notifyListeners();
  }


  void Logout() {
    _CurrentUser.Logout();
    notifyListeners();
  }





}
