import 'package:flutter/material.dart';
import 'package:it_project_homework/assets/Themes/SystemTheme.dart';

import 'LableText.dart';


AlertDialog AlertPopupDialog(BuildContext context, String title, String Message,
    {String ActionLable}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: LableTitle(title, color: ArgonColors.warning),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[LableTitle(Message, FontSize: 10)],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(ActionLable),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}
