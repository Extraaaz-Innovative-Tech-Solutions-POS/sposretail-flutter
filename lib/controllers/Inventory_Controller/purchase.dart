import 'package:spos_retail/model/Inventory/history/inventory_history.dart';
import 'package:spos_retail/model/Inventory/paymentList.dart';
import 'package:spos_retail/model/Inventory/purchaseModel.dart';
import 'package:spos_retail/model/common_model.dart';
import '../../views/widgets/export.dart';

class PurchaseController extends GetxController {
  List<History> inventoryHistoryList = [];

 // RxList<History> inventoryHistoryList = <History>[].obs;
  RxList<PaymentDetailsModel> paymentDetails = <PaymentDetailsModel>[].obs;

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
        debugPrint("Purchase Create sucessfully");
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
        debugPrint("Purchase Delete Sucessfully");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addPayment(int id, int isFullPaid, int isPartial, String status,
      int amountPaid, String paymentType) async {
    try {
      AddPayment addPayment = AddPayment(
          isFullPaid: isFullPaid,
          isPartial: isPartial,
          status: status,
          amount_paid: amountPaid,
          payment_type: paymentType);
      final response = await DioServices.postRequest(
          AppConstant.addPayment, addPayment.toJson());
      if (response.statusCode == 200) {
        debugPrint("Payment Added Sucessfully");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> inventoryHistory() async {
    try {
      final response = await DioServices.get(AppConstant.inventoryHistory);
      if (response.statusCode == 200) {
        print(response);


        // topsellingList.assignAll((response.data['data'] as List)
        //     .map((orderJson) => TopSelling.fromJson(orderJson)));

        // update();



        inventoryHistoryList.assignAll((response.data['history'] as List)
            .map((orderJson) => History.fromJson(orderJson)));
/////////////////////////////////

            //  inventoryHistoryList = response.data['data']
            // .map<History>(
            //     (json) => History.fromJson(json))
            // .toList();
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> viewPaymentList(String id) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      final response = await DioServices.get(AppConstant.viewPayment+"/$id");
      if (response.statusCode == 200) {
        paymentDetails.assignAll((response.data['paymentDetails'] as List)
            .map((orderJson) => PaymentDetailsModel.fromJson(orderJson)));
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
