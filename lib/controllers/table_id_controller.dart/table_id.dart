import '../../views/widgets/export.dart';

class TableIdController extends GetxController{

  var dineTableId, takeAwayId;

  Future<void> dineinTable(String ordertype, tableId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (ordertype == "Dine") {
      final response = await DioServices.get(AppConstant.dineId);
      if (response.statusCode == 200) {
        if (tableId == null) {
          dineTableId = response.toString();
          prefs.setString("DineTableID", dineTableId);
          update();
        } else {
          print("ID is already created");
        }
      }
    } else {
      final response = await DioServices.get(AppConstant.takeAwayID);
      print("Your TakeAwayID value-------->");
      print(response.toString());
      if (response.statusCode == 200) {
        takeAwayId = response.toString();
        prefs.setString("TakeAwayTableID", takeAwayId);
        update();
      }
    }
  }
}