import 'package:spos_retail/views/widgets/export.dart';

class TableTransferController extends GetxController {
  final activetablecontroller = Get.put(ActiveTableController());
  final fetchfloorTable = Get.put(FloorController());

  void tableTranfer(tableId, floorId, sectionId, tableNo) async {
    try {
      final response = await DioServices.postRequest(AppConstant.transfer, {
        "table_id": tableId,
        "floor_id": floorId,
        "section_id": sectionId,
        "table_number": tableNo
      });
      // print(response.data);

      if (response.statusCode == 200) {
        activetablecontroller.fetchActiveTable();
        fetchfloorTable.fetchFloorTable(true, "Dine");
        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    }
  }

//   table_id:DI/PCQO1505242968
// floor_id:75
// section_id:14
// table_number:4
}
