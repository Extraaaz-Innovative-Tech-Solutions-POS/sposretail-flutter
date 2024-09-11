import 'dart:developer';

import 'package:spos_retail/model/common_model.dart';

import '../views/widgets/export.dart';

class CompleteOrderController extends GetxController {
  var grandTotal;

  
      final  controller = Get.put(CartController());



   final customerdetailsController =
      Get.put(CustomerlistController());



    //     final customerName = controller.cartOrder.value!.customer == null
    //     ? "-"
    //     : controller.cartOrder.value!.customer!.name.toString();
    // final mobileNo = controller.cartOrder.value!.customer == null
    //     ? "-"
    //     : controller.cartOrder.value!.customer!.phone.toString();
    // final address = controller.cartOrder.value!.customer == null
    //     ? "-"
    //     : controller.cartOrder.value!.customer!.address.toString();

  void completeOrderPost(
    String table_id,
    int paid,
    String paymenttype,
    orderType,
    var fullpaid,
    var is_partial_paid,
    var money_given,
    var delivery_address_id,
    int discounted_amount,
    BuildContext context,
  ) async {
    final CartController controller = Get.put(CartController());
    CompleteOrderModel completeOrderModel = CompleteOrderModel(
      table_id: table_id,
      paid: paid,
      payment_type: paymenttype,
      isFull: fullpaid,
      isPartial: is_partial_paid,
      moneyGiven: money_given,
      delivery_address_id: delivery_address_id,
      discounted_amount: discounted_amount,
    );

    try {
      final response = await DioServices.postRequest(
        AppConstant.completeOrder,
        completeOrderModel.toJson(),
      );



print("complete order....testing ${response.data}");
      if (response.statusCode == 200) {
        grandTotal = response.data['data']['grand_total'];
        update();

        Get.to(BottomNav());
         snackBar("Success", "Order Completed Successfully");

        await controller.completeBilling(
          orderType,
          controller.ordernumber.toString(),
          response.data['data']['total_discount'] ?? 0,
          response.data['data']['grand_total'],
          response.data['data']['remaining_money'],
          response.data['data']['total_given_amount'],
          true,
          context,
          controller.orderedItems,
          customername:  controller.cartOrder.value!.customer!.name.toString(),
          customerphone: controller.cartOrder.value!.customer!.phone.toString(),
          customeraddress: controller.cartOrder.value!.customer!.address.toString()
        );
        //Get.to(BottomNav());

        //navigateAfterCompletion(orderType);
        // snackBar("Success", "Order Completed Successfully");
      } else {
        snackBar("Error", "Order Failed to Complete");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void completeAdvanceOrder(
    String table_id,
    int paid,
    String paymenttype,
    amount,
    int isPartial,
    int isFull,
    int discount,
    bool fullpayment,
    BuildContext context,
  ) async {
    final CartController controller = Get.put(CartController());
    CompleteOrderModel completeOrderModel = CompleteOrderModel(
      table_id: table_id,
      paid: paid,
      payment_type: paymenttype,
      moneyGiven: amount,
      isPartial: isPartial,
      isFull: isFull,
      discounted_amount: discount,
    );

    try {
      final response = await DioServices.postRequest(
        AppConstant.completeOrder,
        completeOrderModel.toJson(),
      );

      if (response.statusCode == 200) {
        await controller.completeBilling(
          "Advance",
          controller.ordernumber.toString(),
          response.data['data']['total_discount'] ?? 0,
          response.data['data']['grand_total'],
          response.data['data']['remaining_money'],
          response.data['data']['total_given_amount'],
          customeraddress: response.data['data']['customer']['address'],
          customername: response.data['data']['customer']['name'],
          customerphone: response.data['data']['customer']['phone'],
          fullpayment,
          context,
          controller.orderedItems,
        );

        Get.to(BottomNav());
        snackBar("Success", "Order Completed Successfully");
      } else {
        snackBar("Error", "Order Failed to Complete");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // void navigateAfterCompletion(String orderType) {
  //   switch (orderType) {
  //     case "Dine-In":
  //       Get.to(FloorSectionTable());
  //       break;
  //     default:
  //       Get.to(BottomNav());
  //       break;
  //   }
  // }
}
