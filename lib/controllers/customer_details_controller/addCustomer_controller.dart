import 'package:spos_retail/model/common_model.dart' as cm;
import 'package:spos_retail/views/widgets/export.dart';

class AddCustomerController extends GetxController {

  RxString newName = "".obs;

   // Address
    RxString newCustomerAddress ="nill".obs;

    RxInt newCustomerID =0.obs;



  CustomerlistController customerdetailsController =
      Get.put(CustomerlistController());
  final GetCustomerAddressController customerAddressController =
      Get.put(GetCustomerAddressController());

       late List<Customermodel> customerList;

  Future<void> postcustomer(String name,  String phone) async {
    try {
      addCustomer addNewCustomer =
          addCustomer(name: name, address: newCustomerAddress.value , phone: phone);
      final response =
          await DioServices.postRequest("customer", addNewCustomer.toJson());

      if (response.statusCode == 200) {
        customerdetailsController.getcustomerlist(false);
        newCustomerID= customerList[customerList.length-1].id! as RxInt; 
      //  Get.back();
        snackBar("Success", "Added Sucessfully");
        saveContacts(name, phone);
        Fluttertoast.showToast(msg: "Added Sucessfully");
        update();
        // print("New Customer Added");
      } else {
        // print("Unsuccessful");
      }
    } catch (e) {
      snackBar("Error", e.toString());
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
