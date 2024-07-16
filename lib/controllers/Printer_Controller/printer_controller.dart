import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spos_retail/views/widgets/export.dart';

import '../../constants/web_sockets.dart';

class PrinterController extends GetxController {
  var flag = false.obs;
  var notedtimes = 0.obs;
  final WebSocketService _webSocketService = WebSocketService();

  RxString _printerStatus = "".obs;

  @override
  void onInit() {
    super.onInit();
    notedtimes = 0.obs;
    flag = false.obs;
    _initializeWebSocket();
    update();
  }

  void _initializeWebSocket() {
    _webSocketService.connect('ws://localhost:8080');
    _webSocketService.listen(_onMessageReceived);
    update();
  }

  void _onMessageReceived(dynamic message) {
    _printerStatus.value = message;
    update();
  }

  Future<void> postData(BillPrinterModel formData) async {
    while (true) {
      DateTime times = DateTime.now();
      var calculatedTime = times.second - notedtimes.value;

      if (calculatedTime.abs() > 5) {
        print("--------------->" + _printerStatus.value);
        flag.value = true;
        update();
        await _makePostRequest('http://localhost:2001', formData.toJson());
        break;
      } else {
        print("----------------->" + _printerStatus.value);
        await Future.delayed(Duration(seconds: 5));
        // launchApp("com.example.myapplication");
        flag.value = true;
        update();
        await _makePostRequest('http://localhost:2001', formData.toJson());
        break;
      }
    }
  }

  Future<void> kotPrinterPost(KOTPrinterModel formData) async {
    while (true) {
      DateTime times = DateTime.now();
      var calculatedTime = times.second - notedtimes.value;

      if (calculatedTime.abs() > 5) {
        flag.value = true;
        update();
        await _makePostRequest('http://localhost:2001', formData.toJson());
        notedtimes.value = times.second;
        break;
      } else {
        await Future.delayed(Duration(seconds: 5));
        // launchApp("com.example.myapplication");
        flag.value = true;
        update();
        await _makePostRequest('http://localhost:2001', formData.toJson());
        notedtimes.value = times.second;
        break;
      }
    }
  }

  Future<void> _makePostRequest(String url, Map<String, dynamic> data) async {
    try {
      Dio dio = Dio();
      var response = await dio.post(
        url,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        log('Request Successful: ${data}');
      } else {
        log('Request Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }

  // void launchApp(String packageName) async {
  //   if (await DeviceApps.isAppInstalled(packageName)) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var existingPrinter =
  //         prefs.getString("BillingPrinter"); // corrected method to getString

  //     if (existingPrinter != null) {
  //       final AndroidIntent intent = AndroidIntent(
  //         package: "com.example.myapplication",
  //         arguments: {"status": "Null"},
  //       );
  //       intent.sendBroadcast();

  //       // ensure context is available or use context from the method parameters
  //     } else {
  //       print("Printer is not connected");
  //     }
  //   } else {
  //     print('App is not installed.');
  //     // Handle the case where the app is not installed
  //   }
  // }

//}
}
