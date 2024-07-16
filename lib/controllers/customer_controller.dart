import 'package:get/get.dart';
import 'package:spos_retail/model/customer_model.dart';

import '../services/dio_services.dart';

class CustomerController extends GetxController {
  List<Customer>? customers;

  Future<void> getAllCustomer() async {
    try {
      final response = await DioServices.get("customer");

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON data

        // Initialize the customers list if it's null
        customers ??= [];

        // Map each item in the result to Customer objects and add them to the list
        response.data.forEach((value) {
          customers!.add(Customer.fromJson(value));
        });
        update();
      } else {
        // Handle non-200 status codes (e.g., display an error message)
        Get.snackbar("Error", "Failed to fetch customer data");
      }
    } catch (error) {
      // Handle any exceptions that might occur during the request or decoding

      Get.snackbar("Error", "An error occurred while fetching customer data");
    }
  }

  Future<void> postCustomer(Customer customer) async {
    try {
      final response =
          await DioServices.postRequest("customer", customer.toJson());
      print(" status code is : ${response.statusCode}");
      // Check if the response is successful (status code 200)
      if (response.statusCode == 201) {
        Get.snackbar("Done", "Customer Added Successfully");
        getAllCustomer();
      } else if (response.statusCode == 400) {
        Get.snackbar(
            "Error", "A customer with the same phone number already exists.");
      } else {
        // Handle non-200 status codes (e.g., display an error message)
        Get.snackbar("Error", "Failed to Add customer data");
      }
    } catch (error) {
      // Handle any exceptions that might occur during the request or decoding

      Get.snackbar("Error", "An error occurred while Adding customer data");
    }
  }
}
