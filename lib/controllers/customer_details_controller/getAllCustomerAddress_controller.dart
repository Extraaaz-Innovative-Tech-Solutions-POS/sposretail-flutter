import '../../views/widgets/export.dart';

class GetCustomerAddressController extends GetxController {
  List<CustomerAddressData> customerAddressList = [];
  Future<void> getCustomerAddressController(String id) async {
    var response = await DioServices.get("${AppConstant.customerAddress}/${id}");
    try {
      if (response.statusCode == 200) {
      
        customerAddressList.assignAll((response.data['data'] as List)
            .map((orderJson) => CustomerAddressData.fromJson(orderJson)));
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
