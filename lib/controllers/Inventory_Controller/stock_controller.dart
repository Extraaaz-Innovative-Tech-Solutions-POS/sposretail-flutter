
import '../../views/widgets/export.dart';

class StockController extends GetxController{
  RxString thresholdValue = "".obs;
  RxString returnQuantity = "0".obs;
  final purchaseController = Get.put(PurchaseController());
  final recipeController = Get.put(RecipeController());


    Future<void> setThresholdValue(id) async {
    try {
      final response = await DioServices.postRequest(AppConstant.setThresoldValue,
          {"ingredient_id": id, "threshold_value": thresholdValue.value});
          print(response.statusCode);
          print(response.statusMessage);
      if (response.statusCode == 200) {
        print("SET THRESHOLD -------------------------------------->");
      
        print(response.data);
        snackBar("Success", "Threshold Set Successfully");

          recipeController.getIngredientList();
          thresholdValue.value = "";
      }
    } catch (e) {
      print(e);
    }
  }

  returnStock(purchaseId, name, quantity, reason, supplierId, rate, amount) async {
    try{
      final response = await DioServices.postRequest(AppConstant.returnStock, {
      "purchase_id": purchaseId,//"3",
      "product_name": name,//"potatto",
      "product_quantity": quantity,
      "returnQuantity": returnQuantity.value,
      "reason": reason,//"Return ",
      "supplier_id": supplierId,
      "rate": rate,
      "amount": amount
    });
    purchaseController.getPurchase();
    Get.back();
    print("RETURN STOCK ------------------>");
    print(response.data);
    } catch(e) {

    }
  }



}