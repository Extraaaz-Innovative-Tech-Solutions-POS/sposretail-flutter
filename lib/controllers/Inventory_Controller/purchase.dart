import 'package:spos_retail/model/Inventory/history/inventory_history.dart';
import 'package:spos_retail/model/Inventory/paymentList.dart';
import 'package:spos_retail/model/Inventory/purchaseModel.dart';
import 'package:spos_retail/model/common_model.dart';

import '../../model/Inventory/payment/payment_details.dart';
import '../../views/widgets/export.dart';

class PurchaseController extends GetxController {
  RxList<PurchaseData> purchaseList = <PurchaseData>[].obs;
  RxList<History> inventoryHistoryList = <History>[].obs;
  RxList<PaymentDetailsModel> paymentDetails = <PaymentDetailsModel>[].obs;
  Future<void> createPurchase(
      int supplierId,
      String productName,
      String invoiceNumber,
      int unit,
      int quantity,
      int rate,
      int cgst,
      int sgst,
      int vat,
      int tax,
      String discount) async {
    AddPurchase addPurchase = AddPurchase(
        supplierId: supplierId,
        productName: productName,
        invoiceNumber: invoiceNumber,
        unit: unit,
        quantity: quantity,
        rate: rate,
        cgst: cgst,
        sgst: sgst,
        vat: vat,
        tax: tax,
        discount: discount);

    try {
      final response = await DioServices.postRequest(
          AppConstant.createPurchase, addPurchase.toJson());
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
        purchaseList.assignAll((response.data as List)
            .map((orderJson) => PurchaseData.fromJson(orderJson)));
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

  Future<void> inventoryHistory() async {
    try {
      final response = await DioServices.get(AppConstant.inventoryHistory);
      if (response.statusCode == 200) {
        inventoryHistoryList.assignAll((response.data as List)
            .map((orderJson) => History.fromJson(orderJson)));
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> viewPaymentList() async {
    try {
      final response = await DioServices.get(AppConstant.viewPayment);
      if (response.statusCode == 200) {
        paymentDetails.assignAll((response.data as List)
            .map((orderJson) => PaymentDetailsModel.fromJson(orderJson)));
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
