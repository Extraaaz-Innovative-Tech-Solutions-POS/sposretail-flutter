import 'package:spos_retail/model/Inventory/purchaseModel.dart';
import 'package:spos_retail/model/common_model.dart';

import '../../views/widgets/export.dart';

class PurchaseController extends GetxController {

  //RxList<PurchaseData> purchaseList = <PurchaseData>[].obs;
  List<PurchaseData> purchaseList = [];
  Future<void> createPurchase(
      // int supplierId,
      // String productName,
      // String invoiceNumber,
      // int unit,
      // int quantity,
      // int rate,
      // int cgst,
      // int sgst,
      // int vat,
      // int tax,
      // String discount
      ) async {
    // AddPurchase addPurchase = AddPurchase(
    //     supplierId: supplierId,
    //     productName: productName,
    //     invoiceNumber: invoiceNumber,
    //     unit: unit,
    //     quantity: quantity,
    //     rate: rate,
    //     cgst: cgst,
    //     sgst: sgst,
    //     vat: vat,
    //     tax: tax,
    //     discount: discount       
    //     );

    try {
      final response = await DioServices.postRequest(
          AppConstant.createPurchase, {
            "supplier_id": 4,
  "product_name": "oil",
  "unit": "kg",
  "quantity": 10,
  "rate": 200,
  "cgst": "",
  "sgst": "",
  "vat": "",
  "tax": false,
  "discount": "",
  "is_full_paid": 1,
  "is_partial":0,
  "status": "Completed",
  "amount_paid": 2000,
  "payment_type":"cash"
          });
      if (response.statusCode == 200) {
        print("Purchase Create sucessfully");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPurchase() async {
    try {
      final response = await DioServices.get(AppConstant.purchaseList);
      if (response.statusCode == 200) {


         purchaseList = response.data['data']
            .map<PurchaseData>(
                (json) => PurchaseData.fromJson(json))
            .toList();



        // purchaseList.assignAll((response.data as List)
        //     .map((orderJson) => PurchaseData.fromJson(orderJson)));
        update();
        print(purchaseList.length);
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
