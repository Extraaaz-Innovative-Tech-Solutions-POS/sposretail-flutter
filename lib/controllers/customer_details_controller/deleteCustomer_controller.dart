import '../../views/widgets/export.dart';

class DeleteCustomerController extends GetxController {
  final CustomerlistController customerListcontroller =
      Get.put(CustomerlistController());
  Future<void> deleteCustomer(String id,) async {
    try {
      final response = await DioServices.delete("customer/$id");
      if (response.statusCode == 200) {
        customerListcontroller.getcustomerlist();
        update();
        snackBar("Success", "Customer  Deleted Successfully");
      }
    } catch (e) {
      print('Unsuccessful $e');
    }
  }
}
// .