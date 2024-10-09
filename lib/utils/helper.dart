import 'package:flutter/material.dart';
import 'package:spos_retail/views/widgets/toggle_setting.dart';

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

enum MenuItemType { KOT, CUSTOMER }

getMenuItemString(MenuItemType menuItemType) {
  switch (menuItemType) {
    case MenuItemType.KOT:
      return "Kot";
    case MenuItemType.CUSTOMER:
      return "Customer";
  }
}

Future<void> showPopUpMenu(BuildContext context, Offset offset) async {
  final screenSize = MediaQuery.of(context).size;
  double left = offset.dx;
  double top = offset.dy;
  double right = screenSize.width - offset.dx;
  double bottom = screenSize.height - offset.dy;

  await showMenu<MenuItemType>(
    context: context,
    position: RelativeRect.fromLTRB(left, top, right, bottom),
    items: [
       PopupMenuItem<MenuItemType>(
          value: MenuItemType.KOT, child: ToggleSetting()),
    ],
  );
}

const String AMS_Mantan = 'AMS Manthan Regular';
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

//var scaffoldKey = GlobalKey<ScaffoldState>();

bool investorStatus = false;
bool fundManagerStatus = false;
TransformationController transformationController = TransformationController();
