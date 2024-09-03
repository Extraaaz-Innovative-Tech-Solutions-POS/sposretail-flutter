

import '../../views/widgets/export.dart';

class UpdateCustomerController extends GetxController {
  static RxBool isLoading = false.obs;
  final CustomerlistController customerlistcontroller =
      Get.put(CustomerlistController());
  Future<void> updatecustomer(
    String customerId,
    String customerName,
    String customerphone,
    String customeraddress,
  ) async {
    try {
      isLoading.value = true;
      final response = await DioServices.put("customer/$customerId", {
        "name": customerName,
        "address": customeraddress,
        "phone": customerphone,
      });
      if (response.statusCode == 200) {
        update();
        customerlistcontroller.getcustomerlist(false);
         Get.back();
        // Get.to(Customerdetails());
        snackBar("Success", "Updated Sucessfully");
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
