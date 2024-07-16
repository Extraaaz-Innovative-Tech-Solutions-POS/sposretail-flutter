import 'package:spos_retail/views/widgets/export.dart';

class ItemCancelController extends GetxController {
  Future<void> fetchMenu(
      String table_id, int item_id, String reason_cancel, context) async {
    CancelOrder cancelOrder = CancelOrder(
        tabel_id: table_id, item_id: item_id, reason_cancel: reason_cancel);

    try {
      final response = await DioServices.postRequest(
          AppConstant.cancelItem, cancelOrder.toJson());

      if (response.statusCode == 200) {
        snackBarBottom("Success", "Item delete Sucessfully", context);
        update();
      } else {
        print("Error im form emnu: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    }
  }
}
