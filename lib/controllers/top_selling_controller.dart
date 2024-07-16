import 'package:dio/dio.dart' as services;
import 'package:spos_retail/views/widgets/export.dart';

class TopSellingDashboardController extends GetxController {
  // DashboardData? dashboardData;
  RxList<TopSelling> topsellingList = <TopSelling>[].obs;

  List<String> titles = [
    "Today's Sale",
    "Today's Orders",
    "Today's Invoices",
    "Yesterday's Orders",
    "Monthly Sales",
  ];
  List<dynamic> datadashboardList = [].obs;

  Future<services.Response> fetchDashboard() async {
    final url = "${AppConstant.baseUrl}/${AppConstant.topSelling}";
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
        topsellingList.assignAll((response.data['data'] as List)
            .map((orderJson) => TopSelling.fromJson(orderJson)));

        update();
      }
      return response;
    } catch (error) {
      print('Error: $error');
      throw error; // Re-throw the error to propagate it further if needed
    }
  }
}
