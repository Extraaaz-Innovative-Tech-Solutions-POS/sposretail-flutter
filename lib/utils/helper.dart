import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

Widget spacer(double? height) {
  return SizedBox(
    height: height ?? 10,
    // width: width,
  );
}

const String AMS_Mantan = 'AMS Manthan Regular';
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

//var scaffoldKey = GlobalKey<ScaffoldState>();

bool investorStatus = false;
bool fundManagerStatus = false;
TransformationController transformationController = TransformationController();
