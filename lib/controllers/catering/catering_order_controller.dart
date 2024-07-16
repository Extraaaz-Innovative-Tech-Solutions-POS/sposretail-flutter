import 'dart:developer';
import 'package:spos_retail/model/cart_respose_model.dart';
import 'package:spos_retail/views/catering/cateringOngoingOrder.dart';

import '../../views/widgets/export.dart';

class CateringOrderController extends GetxController {
  List<Items> orderedItems = [];
  Rx<Kot?> cartOrder = Rx<Kot?>(null);
  RxBool successful = false.obs;
  List<Kot> kot = [];
  List<Item> selectedItemList = [];
  RxBool completingOrder = false.obs;
  var ordernumber;
  RxList<TakeAwayOrder> takewayorders = <TakeAwayOrder>[].obs;
  final CartController cartcontroller = Get.put(CartController());
  confirmCatAdvOrder(tableId, items, customerId, time) async {
    try {
      final response =
          await DioServices.postRequest(AppConstant.confirmCateringOrder, {
        "table_id": tableId, //"CAT/ZNEO0305249089",
        "items": items,
        "orderType": "Catering",
        "customerId": customerId, //"10",
        "advance_order_date_time": time,
      });
      // selectedItemList.clear();
      update();
      response.statusCode == 200
          ? confirmCatBillingOrder(tableId)
          : snackBar("Failed", "Order Failed");
    } catch (e) {}
  }

  cancelCatAdvOrder(tableId, items, customerId, time) async {
    try {
      final response =
          await DioServices.postRequest(AppConstant.cancelCateringOrder, {
        "table_id": tableId, //"CAT/ZNEO0305249089",
        "items": items,
        "orderType": "Catering",
        "customerId": customerId, //"10",
        "advance_order_date_time": time
      });
      print(response.data);
      response.statusCode == 200
          ? confirmCatBillingOrder(tableId)
          : snackBar("Failed", "Order Failed");
    } catch (e) {}
  }

  confirmCatBillingOrder(tableId) async {
    try {
      final response = await DioServices.get(AppConstant.billCatering,
          queryParameters: {"table_id": "$tableId", "order_Type": "Catering"});
      if (response.statusCode == 200) {
        cartOrder.value = Kot.fromJson(response.data['kot']);
        orderedItems.assignAll(cartOrder.value!.items!);
        ordernumber = response.data['kot']['order_number'];
        successful.value = true;

        update();

        Get.to(
            () => CateringOngoingOrder(item: orderedItems, table_id: tableId));
      } else {
        successful.value = true;
        orderedItems.clear();
      }
    } catch (e) {
      successful.value = false;
      orderedItems.clear();
      snackBar("Error", e.toString());
    } finally {
      update();
    }
  }

  updatePendingOrders(String tableId, String paymentType, String ispartialpaid,
      String isFullPaid, int moneygiven, context, List<Items> order) async {
    try {
      final response =
          await DioServices.postRequest(AppConstant.partialCateringPayment, {
        "table_id": tableId,
        "payment_type": paymentType,
        "is_partial_paid": ispartialpaid,
        "is_full_paid": isFullPaid,
        "money_given": moneygiven
      });

      if (response.statusCode == 200) {
        final CartController controller = Get.put(CartController());
        // update();
        log("Money Given------------------>${response.data['data']['payments'][1]['money_given']}");
        controller
            .completeBilling(
                "Catering",
                response.data['data']['invoice_id'].toString(),
                double.parse(response.data['data']['total_discount'] ?? "0"),
                //response.data['data']['total_discount'] ?? 0,
                // int.parse(priceController.text)

                response.data['data']['total'].toString(),
                response.data['data']['remaining_money'],
                response.data['data']['payments'][1]['money_given'],
                false,
                context,
                order,
                customeraddress: response.data['data']['customer']['address'],
                customername: response.data['data']['customer']['name'],
                customerphone: response.data['data']['customer']['phone'],
                numberOfthali: response.data['data']['no_of_thali'],
                thaliPrice: response.data['data']['thali_price'],
                datetime: response.data['data']['order_date'])
            .whenComplete(() => Get.to(BottomNav()));
        print(response.data);
        snackBar("Success", "Order Completed Successfully");

        Get.to(BottomNav());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  completeCatAdvOrder(tableId, paymentType, partial, full, disc, price,
      thaliCount, moneyGiven, context, List<Items> order) async {
    try {
      final CartController controller = Get.put(CartController());
      final response =
          await DioServices.postRequest(AppConstant.completeCatering, {
        "table_id": tableId,
        "ispaid": "100",
        "payment_type": paymentType,
        "is_partial_paid": partial,
        "is_full_paid": full,
        "discount": disc,
        "thali_price": price,
        "no_of_thali": thaliCount,
        "money_given": moneyGiven
      });
      print(response.data);
      if (response.statusCode == 200) {
        controller
            .completeBilling(
                "Catering",
                response.data['data']['invoice_id'].toString(),
                double.parse(response.data['data']['total_discount'] ?? "0"),
                //response.data['data']['total_discount'] ?? 0,
                // int.parse(priceController.text)

                response.data['data']['total'].toString(),
                response.data['data']['remaining_money'],
                response.data['data']['total_given_amount'],
                false,
                context,
                order,
                customeraddress: response.data['data']['customer']['address'],
                customername: response.data['data']['customer']['name'],
                customerphone: response.data['data']['customer']['phone'],
                numberOfthali: thaliCount,
                thaliPrice: price,
                datetime: response.data['data']['order_date'])
            .whenComplete(() => Get.to(BottomNav()));
        snackBar("Success", "Partial Order Completed Successfully");
      } else {
        snackBar("Failed", "Order Failed to complete");
      }
    } catch (e) {}
  }

  cancelItemCatAdvOrder(tableId, itemId) async {
    try {
      final response = await DioServices.postRequest(
          AppConstant.cancelCatering, {
        "table_id": tableId,
        "item_id": itemId,
        "cancel_reason": "Not want"
      });
      confirmCatBillingOrder(tableId);
      update();
    } catch (e) {
      print(e);
    }
  }
}
