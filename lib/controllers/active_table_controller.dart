import 'package:spos_retail/model/active_table.dart' as a;
import '../views/widgets/export.dart';

class ActiveTableController extends GetxController {
  List<a.Data> activeTableList = [];

  Map<String, dynamic> tablesAtive = {};
  var tablenumber = "".obs;
  Future<void> fetchActiveTable() async {
    try {
      final response = await DioServices.get(AppConstant.activeTable);
      // print(
      //     "ACTIVE TABLE : --------------------------------------------${response.data}");
      if (response.statusCode == 200) {
        // tablenumber = response.data['data'];
        activeTableList = response.data['data']
            .map<a.Data>((json) => a.Data.fromJson(json))
            .toList();

        update();
      }
    } catch (e) {
      print(e);
    }
  }

  String? checkbooked(int table, int section_id, int floorid) {
    for (final activeTable in activeTableList) {
      if (activeTable.tableNumber == table &&
          activeTable.sectionId == section_id &&
          activeTable.floorId == floorid) {
        for (final tableData in activeTable.tableData!) {
          if (tableData.createdAt != null) {
            return tableData.createdAt;
          }
        }
      }
    }
    return null;
  }
}
