import 'package:get/get.dart';
import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/services/dio_services.dart';

class TableControllers extends GetxController {
  final count = RxInt(0);
  final List<String> griditem = [];

  postTables(int floor_number, int tables, int section_id) async {
    AddTables addTables = AddTables(
        floor_number: floor_number, table: tables, section_id: section_id);
    var response =
        await DioServices.postRequest("setTables", addTables.toJson());
    if (response.statusCode == 200) {
      print("You Tables is added Sucessfully");
    }
  }
}
