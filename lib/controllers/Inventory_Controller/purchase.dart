import 'package:spos_retail/model/Inventory/purchase/purchase_list_data.dart';
import 'package:spos_retail/model/common_model.dart';
import '../../views/widgets/export.dart';

class PurchaseController extends GetxController {
  RxList<PurchaseListData> purchadseListdata = <PurchaseListData>[].obs;
  RxInt restaurantId = 1.obs;
  RxString purchaseName = "".obs;
  RxString purchaseUnit = "".obs;
  RxString purchaseQuantity = "".obs;
  RxString purchaseRate = "".obs;
  RxString purchaseCgst = "".obs;
  RxString purchaseSgst = "".obs;
  RxString purchaseDiscount = "".obs;
  RxString purchaseAmount = "".obs;
  RxString purchaseNetRange = "".obs;

  Future<void> createPurchase(context, supplierId) async {
    if (purchaseName.value.isNotEmpty &&
        purchaseUnit.value.isNotEmpty &&
        purchaseQuantity.value.isNotEmpty &&
        purchaseRate.value.isNotEmpty &&
        purchaseCgst.value.isNotEmpty &&
        purchaseSgst.value.isNotEmpty &&
        purchaseUnit.value.isNotEmpty &&
        purchaseNetRange.value.isNotEmpty &&
        purchaseAmount.value.isNotEmpty) {
      try {
        final response =
            await DioServices.postRequest(AppConstant.createPurchase, {
          "supplier_id": supplierId, //4,
          "product_name": purchaseName.value,
          "unit": purchaseUnit.value,
          "quantity": purchaseQuantity.value,
          "rate": purchaseRate.value,
          "cgst": purchaseCgst.value,
          "sgst": purchaseSgst.value,
          "vat": "",
          "tax": false,
          "discount": purchaseDiscount.value,
          "is_full_paid": 1,
          "is_partial": 0,
          "status": "Completed",
          "amount_paid": purchaseAmount.value,
          "payment_type": "cash"
        });
        if (response.statusCode == 200) {
          snackBar("Success", "Purchase Created Successfully");
          print(response.data);
          restaurantId.value = response.data["data"]["restaurant_id"];
          print(restaurantId);
          update();
          getPurchase();
          Get.off(PurchaseUI());
        }
      } catch (e) {
        print(e);
      }
    } else {
                        snackBarBottom(
                            "Error", "Enter the required field", context);
                      }
  }

  Future<void> getPurchase() async {
    try {
      final response = await DioServices.get(AppConstant.purchaseList);
      if (response.statusCode == 200) {
        print(response.data);
        purchadseListdata.assignAll((response.data['data'])
            .map<PurchaseListData>((json) => PurchaseListData.fromJson(json)));
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePurchase(int id) async {
    try {
      final response =
          await DioServices.delete("${AppConstant.deletePurchase}/$id");
      if (response.statusCode == 200) {
        print("Purchase Delete Sucessfully");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addPayment(int id, int isFullPaid, int isPartial, String status,
      int amount_paid, String payment_type) async {
    try {
      AddPayment addPayment = AddPayment(
          isFullPaid: isFullPaid,
          isPartial: isPartial,
          status: status,
          amount_paid: amount_paid,
          payment_type: payment_type);
      final response = await DioServices.postRequest(
          AppConstant.addPayment, addPayment.toJson());
      if (response.statusCode == 200) {
        print("Payment Added Sucessfully");
      }
    } catch (e) {
      print(e);
    }
  }
}
