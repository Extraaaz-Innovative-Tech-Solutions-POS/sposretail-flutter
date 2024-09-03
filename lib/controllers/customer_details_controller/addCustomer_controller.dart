import 'package:spos_retail/model/common_model.dart' as cm;
import 'package:spos_retail/views/widgets/export.dart';

class AddCustomerController extends GetxController {
  CustomerlistController customerdetailsController =
      Get.put(CustomerlistController());
  final GetCustomerAddressController customerAddressController =
      Get.put(GetCustomerAddressController());
  Future<void> postcustomer(String name, String address, String phone) async {
    try {
      addCustomer addNewCustomer =
          addCustomer(name: name, address: address, phone: phone);
      final response =
          await DioServices.postRequest("customer", addNewCustomer.toJson());

      if (response.statusCode == 200) {
        customerdetailsController.getcustomerlist(false);
        Get.back();
        snackBar("Success", "Added Sucessfully");
        saveContacts(name, phone);
        Fluttertoast.showToast(msg: "Added Sucessfully");
        update();
        // print("New Customer Added");
      } else {
        // print("Unsuccessful");
      }
    } catch (e) {
      print("Error occured");
    }
  }

  Future<void> addAddress(int customerId, String address, String city,
      String state, int pincode, String type, String country) async {
    cm.CustomerAddress customerAddress = cm.CustomerAddress(
        customer_id: customerId,
        address: address,
        city: city,
        state: state,
        pincode: pincode,
        type: type,
        country: country);
    var response = await DioServices.postRequest(
        AppConstant.multipleAddress, customerAddress.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      snackBar("Success", "Address Added Sucessfully");
      customerAddressController
          .getCustomerAddressController(customerId.toString());
      update();
      Get.back();
    }
  }

  void saveContacts(name, phone) async {
    if (await FlutterContacts.requestPermission()) {
      final newContact = Contact()
        ..name.first = name
        ..phones = [Phone(phone)];
      await newContact.insert();
    } else {
      // print("Permision Denied");
    }
  }
}
