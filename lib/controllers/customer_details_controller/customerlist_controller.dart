import 'package:spos_retail/views/widgets/export.dart';

class CustomerlistController extends GetxController {
  List<Customermodel> customer = [];
  Future<void> getcustomerlist(bool download, [int? id]) async {
    try {
      final response = await DioServices.get("customer");
      if (response.statusCode == 200) {
         print(response.statusCode);
         print("CUSTOMER DETAILS : - ${response.data}");

        customer = (response.data['data'] as List)
            .map<Customermodel>((json) => Customermodel.fromJson(json))
            .toList();
        update();

        if (download) {
        
       
          List<Map<String, dynamic>> data = customer
              .map((report) => report
                  .toJson()) 
              .toList();
        
          print(download);
          print("DATA COLLECTED FOR CUSTOMER DETAILS ----------------------------->");
          print(data);
          await createExcelFile(data, "customer_info");
        }
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
