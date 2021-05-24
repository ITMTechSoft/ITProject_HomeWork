import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:it_project_homework/Models/Categories.dart';
import 'package:it_project_homework/Models/Customer.dart';
import 'package:it_project_homework/Models/Orders.dart';
import 'package:it_project_homework/Models/Products.dart';
import 'package:it_project_homework/Models/Visits.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:it_project_homework/Widgets/LableText.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';

/*
Widget DepartmentCard(Employee_DepartmentBLL Item, Function OnTap) {
  return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: ListTile(
        onTap: OnTap,
        title: Text(
          Item.Depart_Name,
          style: TextStyle(fontSize: 20, color: ArgonColors.text),
        ),
        subtitle: Text(Item.Depart_Name),
      ));
}

Widget OneItem({String ItemName, String ItemValue, Function OnTap}) {
  return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: ListTile(
        onTap: OnTap,
        title: Text(
          ItemName,
          style: TextStyle(fontSize: 20, color: ArgonColors.text),
        ),
        subtitle: Text(ItemValue),
      ));
}

Widget OrderCard(QualityDepartment_ModelOrderBLL Item, Function OnTap) {
  return Card(
    child: ListTile(
      onTap: OnTap,
      title: Text(Item.Order_Number),
      subtitle: Text(Item.Model_Name),
      leading: Stack(
        children: <Widget>[
          Container(
            child: Text(
              Item.Order_Number.toUpperCase(),
            ),
            width: 40,
            height: 40,
            alignment: Alignment(0, 0),
          ),
          ClipOval(
            child: Image.network(
              "https://via.placeholder.com/150",
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      trailing: Text(''),
    ),
  );
}

Widget AraControlCard(
    DeptModOrderQuality_ItemsBLL Item, Function Execute, PersonalCase) {
  TextEditingController InputVal = new TextEditingController();
  return Card(
    shadowColor: ArgonColors.black,
    elevation: 10,
    child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 3,
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.ControlAxaisName))),
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.ControlAmount))),
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.ControlError)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 3,
                  child: Center(
                    child: LableTitle(Item.Item_Name, color: ArgonColors.text),
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: LableTitle((Item.Amount ?? 0).toString(),
                        color: ArgonColors.text),
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: LableTitle((Item.Error_Amount ?? 0).toString(),
                        color: ArgonColors.text),
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: StandardButton(
                    Lable: "Sağlim",
                    ForColor: ArgonColors.white,
                    BakColor: ArgonColors.primary,
                    OnTap: () async {
                      int DelValue = int.tryParse(InputVal.text) ?? 1;
                      var NewItem = await Item.CorrectSpecificAmount(DelValue);
                      if (NewItem != null) Item = NewItem;
                      Execute();
                    }),
              ),
              Expanded(
                  child: Input_Form(
                controller: InputVal,
                KType: TextInputType.number,
              )),
              Expanded(
                child: StandardButton(
                    Lable: "Hata",
                    ForColor: ArgonColors.white,
                    BakColor: ArgonColors.warning,
                    OnTap: () async {
                      int DelValue = int.tryParse(InputVal.text) ?? 1;
                      var NewItem = await Item.ErrorSpecificAmount(DelValue);
                      if (NewItem != null) Item = NewItem;
                      Execute();
                    }),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget CuttingPastalControl(PersonalCase, DeptModOrderQuality_ItemsBLL Item,
    Function Approve, Function Reject, Function ReOpenAction) {
  Widget ActionControl = Row(
    children: [
      Expanded(
        child: StandardButton(
            Lable: PersonalCase.GetLable(ResourceKey.ControlValid),
            ForColor: ArgonColors.white,
            BakColor: ArgonColors.primary,
            OnTap: Approve),
      ),
      Expanded(
          child: StandardButton(
              Lable: PersonalCase.GetLable(ResourceKey.ControlInvalid),
              ForColor: ArgonColors.white,
              BakColor: ArgonColors.warning,
              OnTap: Reject)),
    ],
  );
  if (Item.CheckStatus == 1)
    ActionControl = InkWell(
      child: Row(
        children: [
          ClipOval(
            child: Icon(
              Icons.check_circle_rounded,
              color: ArgonColors.success,
            ),
          ),
          Expanded(
            child: Text(PersonalCase.GetLable(ResourceKey.Approved)),
          )
        ],
      ),
      onTap: ReOpenAction,
    );
  else if (Item.CheckStatus == 0)
    ActionControl = InkWell(
      child: Row(
        children: [
          ClipOval(
            child: Icon(
              Icons.cancel_outlined,
              color: ArgonColors.warning,
            ),
          ),
          Expanded(
            child: Text(PersonalCase.GetLable(ResourceKey.Rejected) +
                ': ' +
                Item.Reject_Note),
          )
        ],
      ),
      onTap: ReOpenAction,
    );

  Widget MainRow = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      LableTitle(Item.Item_Name, color: ArgonColors.text),
      ActionControl,
    ],
  );

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 10,
    child: Container(
      padding: EdgeInsets.all(10),
      child: MainRow,
    ),
  );
}

Widget TansifControlList(
    PersonalProvider PersonalCase, QualityDept_ModelOrder_TrackingBLL Item,Function OnTap) {
  Widget FinishStatus = ClipOval(
    child: Icon(
      Icons.check_circle_rounded,
      color: ArgonColors.success,
    ),
  );

  Widget PendingStatus = ClipOval(
    child: Icon(
      Icons.panorama_fish_eye_rounded,
      color: ArgonColors.warning,
    ),
  );

  Widget MainRow = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(


              child: LableTitle(
                PersonalCase.GetLable(ResourceKey.SampleNo)
              )),
          Expanded(
              child: LableTitle((Item.SampleNo ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),

          Expanded(

              child: LableTitle(
                PersonalCase.GetLable(ResourceKey.Sample_Amount),
              )),
          Expanded(
              child: LableTitle((Item.Sample_Amount ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
          Expanded(

              child: LableTitle(
                PersonalCase.GetLable(ResourceKey.Error_Amount),
              )),
          Expanded(
              child: LableTitle((Item.Error_Amount ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(

              child: LableTitle(PersonalCase.GetLable(ResourceKey.SizeName),
    )),
          Expanded(child: LableTitle(Item.SizeName, color: ArgonColors.text,IsCenter: true)),
          Expanded(

              child: LableTitle(
                  PersonalCase.GetLable(ResourceKey.SizeColor_QTY),
         )),
          Expanded(
              child: LableTitle((Item.SizeColor_QTY ?? 0).toString(),
                  color: ArgonColors.text,IsCenter: true)),
          Expanded(

              child: LableTitle(
                  PersonalCase.GetLable(ResourceKey.OrderSizeColor_QTY),
                  )),
          Expanded(
              child: LableTitle((Item.OrderSizeColor_QTY ?? 0).toString(),
                  color: ArgonColors.text,IsCenter: true)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(

              child: LableTitle(PersonalCase.GetLable(ResourceKey.ColorName),
                  )),
          Expanded(
              child: LableTitle(Item.ColorName.toString(),
                  color: ArgonColors.text,IsCenter: true)),
          Expanded(

              child: LableTitle(
                  PersonalCase.GetLable(ResourceKey.Employee_Creator),
                  )),
          Expanded(
              child: LableTitle((Item.Employee_Name ?? 0).toString(),
                  color: ArgonColors.text,IsCenter: true)),
          Expanded(

              child: LableTitle(
                  PersonalCase.GetLable(ResourceKey.Sample_Status),
                  )),
          Expanded(child: Item.Status == ControlStatus.TansifControlCloseStatus ? FinishStatus : PendingStatus),
        ],
      )
    ],
  );

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 10,
    child: Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: OnTap,
        child:  MainRow,),
    ),
  );
}



Widget CuttingModelOrderMatrix(
    PersonalCase, OrderSizeColorDetailsBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedMatrix != null &&
      PersonalCase.SelectedMatrix.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,

    child: InkWell(
      onTap: OnTap,

      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Center(
                  child: LableTitle(Item.SizeParam_StringVal,
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle(Item.ColorParam_StringVal,
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle((Item.PlanSizeColor_QTY ?? 0).toString(),
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle((Item.SizeColor_QTY ?? 0).toString(),
                      color: ArgonColors.text),
                ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget TasnifModelOrderMatrix(
    PersonalCase, OrderSizeColorDetailsBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedMatrix != null &&
      PersonalCase.SelectedMatrix.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,

    child: InkWell(
      onTap: OnTap,

      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Center(
                      child: LableTitle(Item.SizeParam_StringVal,
                          color: ArgonColors.text),
                    )),
                Expanded(
                    child: Center(
                      child: LableTitle(Item.ColorParam_StringVal,
                          color: ArgonColors.text),
                    )),
                Expanded(
                    child: Center(
                      child: LableTitle((Item.SizeColor_QTY ?? 0).toString(),
                          color: ArgonColors.text),
                    )),
                Expanded(
                    child: Center(
                      child: LableTitle((Item.OrderSizeColor_QTY ?? 0).toString(),
                          color: ArgonColors.text),
                    ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget QualityAxisItem(DeptModOrderQuality_ItemsBLL Item,{IsSeleted = false, Function OnTap}) {
  Color SelectedColor;

  if (IsSeleted)
    SelectedColor = ArgonColors.primary;
  else
    SelectedColor = ArgonColors.white;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      focusColor: Colors.lightGreenAccent,
      highlightColor: Colors.deepOrange,
      onTap: OnTap,
      child: Container(
        color: SelectedColor,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: LableTitle(Item.Item_Name),
      ),
    ),
  );
}
*/

Widget GetHeaderAndLable(String lable,String Value){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Expanded(
          child: LableTitle(lable,
              color: ArgonColors.Title)),
      Expanded(flex: 2,
          child: LableTitle(Value,
              color: ArgonColors.text)),
    ],
  );
}

Widget CustomerList(
    PersonalProvider PersonalCase, CustomerBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedCustomer != null &&
      PersonalCase.SelectedCustomer.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GetHeaderAndLable("Full Name",Item.Full_Name),
            GetHeaderAndLable("Email",Item.Email),
            GetHeaderAndLable("Phone",Item.Phone),
          ],
        ),
      ),
    ),
  );
}


Widget ServiceList(
    PersonalProvider PersonalCase, ProductsBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedProduct != null &&
      PersonalCase.SelectedProduct.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GetHeaderAndLable("Service Name",Item.Product_Name),
            GetHeaderAndLable("Category Name",Item.Category_Name),
            GetHeaderAndLable("Price",Item.Price.toString()),
          ],
        ),
      ),
    ),
  );
}

Widget ProductList(
    PersonalProvider PersonalCase, ProductsBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedProduct != null &&
      PersonalCase.SelectedProduct.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GetHeaderAndLable("Product Name",Item.Product_Name),
            GetHeaderAndLable("Category Name",Item.Category_Name),
            GetHeaderAndLable("Price",Item.Price.toString()),
          ],
        ),
      ),
    ),
  );
}

Widget VisitList(
    PersonalProvider PersonalCase, VisitsBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedVisit != null &&
      PersonalCase.SelectedVisit.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GetHeaderAndLable("Visit Name",Item.Visit_Name),
            GetHeaderAndLable("Start Time",Item.Start_Time.toString()),
            GetHeaderAndLable("End Time",Item.End_Time.toString()),
          ],
        ),
      ),
    ),
  );
}

Widget OrderList  (
    PersonalProvider PersonalCase, OrdersBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedOrder != null &&
      PersonalCase.SelectedOrder.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GetHeaderAndLable("Customer Name",Item.Full_Name),
            GetHeaderAndLable("Order Time",Item.Order_Date.toString()),
            GetHeaderAndLable("Total Price",Item.Total_Price.toString()),
            GetHeaderAndLable("Order Note :",Item.Note.toString()),
          ],
        ),
      ),
    ),
  );
}

Widget CategoriesList(
    PersonalProvider PersonalCase, CategoriesBLL Item, Function OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedCategories != null &&
      PersonalCase.SelectedCategories.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GetHeaderAndLable("Categories Name",Item.Category_Name),
            GetHeaderAndLable("Description",Item.Description),
          ],
        ),
      ),
    ),
  );
}
