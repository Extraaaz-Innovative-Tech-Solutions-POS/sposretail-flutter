import 'package:dio/dio.dart' as services;

import '../model/dashboard_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

class DashboardController extends GetxController {
  DashboardData? dashboardData;
  List<MapEntry<dynamic, dynamic>> keyValueList = [];

  List<String> titles = [
    "Today's Sale",
    "Today's Orders",
    "Today's Invoices",
    "Yesterday's Orders",
    "Monthly Sales",
  ];
  List<dynamic> datadashboardList = [].obs;

  Future<services.Response> fetchDashboard() async {
    final url = "${AppConstant.baseUrl}/${AppConstant.dashboardDetails}";
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      services.Dio dio = services.Dio();
      final response = await dio.post(
        url,
        options: services.Options(
          method: "POST",
          receiveDataWhenStatusError: false,
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        dynamic responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          Map<String, dynamic> dashboardList = responseData;

          keyValueList = dashboardList.entries.toList();
        } else {
          // Handle the case where response data is not a map
          print('Something is Wrong in the Dashboard Controller');
        }
      }
      return response;
    } catch (error) {
      print('Error: $error');
      throw error; // Re-throw the error to propagate it further if needed
    }
  }
}
