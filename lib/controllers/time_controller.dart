import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class UtcTimeController extends GetxController {
  String utcTime = "";

  @override
  void onInit() {
    super.onInit();
    _startUpdating();
  }

  void _startUpdating() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      utcTime = DateTime.now().toUtc().toIso8601String();
      update();
    });
  }
}
