import 'package:flutter/material.dart';

Widget textField(context,title, controller, IconData icon, size,
    {IconData? suffixicon,
    void Function()? onTap,
    bool? obscure,
    double? width, TextInputType? keyboardType}) {
  return Container(
    height: 60.0,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 10),
     margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).focusColor),
      color: Theme.of(context).highlightColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      obscureText: obscure ?? false,
      decoration: 
      
      InputDecoration(
        border: InputBorder.none,
           suffixIcon: GestureDetector(onTap: onTap, child: Icon(suffixicon)),
        hintText: "$title",
        contentPadding: const EdgeInsets.only(top: 0.0, bottom: 11.0),
        icon:   Icon(icon),
      )
    ),
  );
}

Widget noObscureTextField(context,title, controller, IconData icon, size,
    {IconData? suffixicon,
    void Function()? onTap,
    double? width, TextInputType? keyboardType}) {
  return Container(
    height: 60.0,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 10),
     margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).focusColor),
      color: Theme.of(context).highlightColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      obscureText: false,
      decoration: 
      
      InputDecoration(
        border: InputBorder.none,
        hintText: "$title",
        contentPadding: const EdgeInsets.only(top: 0.0, bottom: 11.0),
        icon:   Icon(icon),
      )
    ),
  );
}
