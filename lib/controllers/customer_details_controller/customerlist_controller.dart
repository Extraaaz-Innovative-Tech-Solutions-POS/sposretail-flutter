import 'package:spos_retail/views/widgets/export.dart';

class CustomerlistController extends GetxController {
  List<Customermodel> customer = [];
  Future<void> getcustomerlist([int? id]) async {
    try {
      final response = await DioServices.get("customer");
      if (response.statusCode == 200) {
        // print(response.statusCode);
        // print(response.data['data']);

        customer = (response.data['data'] as List)
            .map<Customermodel>((json) => Customermodel.fromJson(json))
            .toList();
        update();
        print("THIS IS ADDRESS : ================${customer[0].address}");
        // Get.to(Customerdetails());
      } else {
        print("Error");
      }
    } catch (e) {
      print(e);
    }
  }
}
