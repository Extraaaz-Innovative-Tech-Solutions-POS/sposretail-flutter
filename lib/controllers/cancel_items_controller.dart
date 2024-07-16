import 'dart:developer';

import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

class CancelOrderController extends GetxController {
  void cancelorderMethod(String tableId, String cancelReason) async {
    try {
      CancelItemModel completeOrderModel =
          CancelItemModel(table_id: tableId, reason_cancel: cancelReason);

      final response = await DioServices.postRequest(
          AppConstant.cancelOrder, completeOrderModel.toJson());
      if (response.statusCode == 200) {
        Get.to(BottomNav(
          pageindex: 1,
        ));
      } else {
        print("Something went wrong------------>");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
