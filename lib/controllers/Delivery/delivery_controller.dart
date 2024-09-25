import 'package:intl/intl.dart';

import '../../model/Delivery/completedDeliveryModel.dart';
import '../../model/Delivery/outForDeliveryModel.dart';
import '../../model/Delivery/pendingOrderModel.dart';
import '../../model/Pending orders/advance_pending_order.dart';
import '../../views/widgets/export.dart';

class DeliveryController extends GetxController {
  List<PendingOrderData> pendingOrderList = [];
  List<AdvancePendingOrderData> pendingAdvanceOrderList = [];
  //List<CateringPendingOrderData> cateringAdvanceOrderList = [];
  List<OutForDeilveryModelData> outForDeliveryList = [];
  List<CompletedDeliveryOrdersData> completedDeliveryOrdersList = [];
  RxBool checkadvance = false.obs;
  Future<void> pendingOrder() async {
    try {
      var response = await DioServices.get(AppConstant.delivery);

      pendingOrderList.assignAll((response.data['data'] as List)
          .map((orderJson) => PendingOrderData.fromJson(orderJson)));

      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> advancedPendingOrder() async {
    try {
      var response = await DioServices.get(AppConstant.pendingAdvance);

      pendingAdvanceOrderList.assignAll((response.data['data'] as List)
          .map((orderJson) => AdvancePendingOrderData.fromJson(orderJson)));
      // print(response.data);
      checkfordavance();
      update();
    } catch (e) {
      print(e);
    }
  }

  // Future<void> cateringAdvancedPendingOrder() async {
  //   try {
  //     var response = await DioServices.get(AppConstant.pendingCateringOrder);
  //     cateringAdvanceOrderList.clear();

  //     cateringAdvanceOrderList.assignAll((response.data['data'] as List)
  //         .map((orderJson) => CateringPendingOrderData.fromJson(orderJson)));
  //     checkfordavance();
  //     update();
  //     // print("CATERING PENDING LENGTH----------------------------");

  //     // print(cateringAdvanceOrderList.length);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> outforDelivery() async {
    try {
      var response = await DioServices.get(AppConstant.outForDelivery);
      outForDeliveryList.assignAll((response.data['data'] as List)
          .map((orderJson) => OutForDeilveryModelData.fromJson(orderJson)));
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateStatusOfDelivery(String tableId) async {
    try {
      var response = await DioServices.postRequest(
          AppConstant.updateStatusForDelivery, {'table_id': tableId});
      if (response.statusCode == 200) {
        snackBar("Success", "Your Order is Delivered Sucessfully");

        update();
        getDeliveryCompletedOrders();
        outforDelivery();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> getDeliveryCompletedOrders() async {
    try {
      var response = await DioServices.get(AppConstant.deliveryCompletedOrders);
      completedDeliveryOrdersList.assignAll((response.data['data'] as List)
          .map((orderJson) => CompletedDeliveryOrdersData.fromJson(orderJson)));
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkfordavance() async {
    DateTime currentDate = DateTime.now();
    for (int index = 0; index < pendingAdvanceOrderList.length; index++) {
      DateTime advanceOrderDate = DateTime.parse(
          pendingAdvanceOrderList[index].advanceOrderDateTime.toString());

      String formattedCurrentDate =
          DateFormat('yyyy-MM-dd').format(currentDate);
      String formattedAdvanceOrderDate =
          DateFormat('yyyy-MM-dd').format(advanceOrderDate);
      if (formattedCurrentDate == formattedAdvanceOrderDate) {
        // Get the time when the popup should stop showing (e.g., 2:00 PM)

        DateTime popupEndTime = DateTime(
            advanceOrderDate.year,
            advanceOrderDate.month,
            advanceOrderDate.day,
            advanceOrderDate.hour,
            advanceOrderDate.minute);

        // Show the popup only if the current time is before the popup end time
        if (DateTime.now().isBefore(popupEndTime)) {
          checkadvance = true.obs;
          update();
        }
      }
    }
  }
}
