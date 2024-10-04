import 'package:flutter/material.dart';

AppBar commonAppBar(context, title, role,  {onpress, List<Widget>? action}) {
  return AppBar(
    iconTheme: IconThemeData(color: Theme.of(context).highlightColor),
    backgroundColor: Colors.transparent,
    title: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: title, style: TextStyle(fontSize: 15, color: Theme.of(context).highlightColor)),
          TextSpan(
              text: role.padLeft(11),
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor)),
        ],
      ),
    ),
    actions: action,
  );
}
