import 'dart:developer';
import '../views/widgets/export.dart';

class RegisterController extends GetxController {
  final RxBool isLoading = false.obs;

  register(
      email, password, name, phone, restaurantName, restaurantAddress, state,
      {bool fromsplash = false}) async {
    try {
      isLoading.value = true;
      final response = await DioServices.postRequest(AppConstant.registerUrl, {
        "email": email,
        "password": password,
        "phone": phone,
        "role": "1",
        "name": name,
        "restaurant_name": restaurantName,
        "address": restaurantAddress,
        "state": state,
        'type': "sales",
      });

      //log("Successfully Register---------->" + response.data.toString());

      if (response.statusCode == 200) {
        snackBar("Success", "Sign Up Successful");

        Get.to(Login());

        bool success = response.data['success'];

        if (success) {
          // snackBar("Failed", "Please enter valid Credentials");
          log("Successfully Register---------->");
        }
      } else {
        //print(response.data);
        snackBar("Failed", "Please enter valid Credentials");
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Network Error",
        content: const Text("Please check your internet connection."),
      );
    } finally {
      isLoading.value = false;
      update(); // Set loading to false regardless of success or failure
    }
  }
}
