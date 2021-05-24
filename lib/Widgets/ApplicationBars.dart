import 'package:flutter/material.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';



 MainBar(PersonalProvider PersonalCase,String Title)=>new AppBar(
   title: new Text(Title),
   actions: <Widget>[
     TextButton.icon(
         onPressed: () {
           PersonalCase.Logout();
         },
         icon: Icon(
           Icons.person,
           color: Colors.white,
         ),
         label: Text(
           "LogOut",
           style: TextStyle(color: Colors.white),
         ))
   ],
 );

DetailBar(String Title,PersonalCase,Function OnTap)=>new AppBar(
  title: new Text(Title),
  actions: <Widget>[
    TextButton.icon(
        onPressed: OnTap,
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        label: Text(
          "Close",
          style: TextStyle(color: Colors.white),
        ))
  ],
);