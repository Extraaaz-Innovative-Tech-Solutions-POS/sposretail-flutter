import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:spos_retail/constants/web_sockets.dart';
import 'package:spos_retail/model/PrinterModel/bill_desktopModel.dart';
import 'package:spos_retail/model/PrinterModel/kot_desktopModel.dart';
import 'package:spos_retail/views/widgets/export.dart';

class DesktopPrinterController extends GetxController {
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

  Future<void> postData(BillDesktopModel formData) async {
    print("DESKTOP FORM DATA JSOn : -------- ${formData.toJson()}");
    while (true) {
      DateTime times = DateTime.now();
      var calculatedTime = times.second - notedtimes.value;

      if (calculatedTime.abs() == 0) {
        print(_printerStatus.value);
        flag.value = true;
        update();
        await _makePostRequest(
            'http://localhost:2001/print', formData.toJson());
        break;
      } else {
        print(_printerStatus.value);
        await Future.delayed(const Duration(seconds: 0));
        flag.value = true;
        update();
        await _makePostRequest(
            'http://localhost:2001/print', formData.toJson());
        break;
      }
    }
  }

  Future<void> kotPrinterPost(KotDesktopModel formData) async {
    while (true) {
      DateTime times = DateTime.now();
      var calculatedTime = times.second - notedtimes.value;

      if (calculatedTime.abs() == 5) {
        flag.value = true;
        update();
        await _makePostRequest(
            'http://localhost:2001/print', formData.toJson());
        notedtimes.value = times.second;
        break;
      } else {
        await Future.delayed(const Duration(seconds: 0));
        flag.value = true;
        update();
        await _makePostRequest(
            'http://localhost:2001/print', formData.toJson());
        notedtimes.value = times.second;
        break;
      }
    }
  }

  Future<void> _makePostRequest(String url, Map<String, dynamic> data) async {
    print("DESKTOP PRINT URL : --- $url + DESKTOP PRINT data : --- $data");
    try {
      Dio dio = Dio();
      var response = await dio.post(
        url,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${settingsController.token}',
    }
        // options.headers['Access-Control-Allow-Origin'] = '*';),
        )  );

      if (response.statusCode == 200) {
        snackBar("Success", "${response.data}");
        print("DESKTOP PRINT MAKE POST REQUEST 200");
        log('Request Successful: $data');
      } else {
        snackBar("Failed", "${response.statusMessage}");
        log('Request Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      snackBar("Failed", "$e");
      print("Error Dewsktop : $e");
      log('Error occurred: ${e.toString()}');
    }
  }
}
