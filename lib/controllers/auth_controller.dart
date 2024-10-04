import 'package:spos_retail/model/user_model.dart';
import 'kitchen_controller.dart';
import 'package:spos_retail/views/widgets/export.dart';

class AuthController extends GetxController {
  final kitchenController = Get.put(KitchenController());
  final userController = Get.put(UserController());
  final RxBool isLoading = false.obs;

  final user = Get.put(UserController());

  login(email, password, {bool fromsplash = false}) async {
    try {
      isLoading.value = true;
      final response = await DioServices.postRequest(AppConstant.loginUrl, {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        print("CUSTOMER DETAILS: ------------------- ${response.data}");
        bool success = response.data['success'];
        if (success == true) {
          snackBar("Success", "Login Successful");

          final token = response.data['data']['token'];
          final name = response.data['data']['user']['name'] ?? "---";
          final sharedrole = response.data['data']['user']['role'];
          var restaurantName = response.data['data']['restaurant'] != null
              ? response.data['data']['restaurant']['name']
              : " ";
          var phoneNo = response.data['data']['user']['phone'] ?? "---";
          var address = response.data['data']['restaurant'] != null
              ? response.data['data']['restaurant']['address']
              : " ";
          var restaurantId = response.data['data']['restaurant'] != null
              ? response.data['data']['restaurant']['id']
              : 0;
          var businessType = response.data['data']['user']['type'] != null
              ? response.data['data']['user']['type'].toString()
              : " ";
          userController.setUser(User.fromJson(response.data["data"]['user']));

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("token", token);
          pref.setBool("saved", true);
          pref.setString("username", email);
          pref.setString("password", password);
          pref.setString('name', name);
          pref.setString('role', sharedrole);
          pref.setString('RestaurantName', restaurantName ?? "--");
          pref.setString("Address", address ?? "--");
          pref.setString("Phone", phoneNo ?? "--");
          pref.setInt("RestaurantId", restaurantId ?? 0);
          pref.setString("BusinessType", businessType ?? "--");

          print("RESTAUANT ID IS THIS: ------------------$restaurantId");

          if (sharedrole == 'manager' || sharedrole == "cashier") {
            userController
                .setUser(User.fromJson(response.data["data"]['user']));
            Get.to(BottomNav());
          }
        } else {
          if (fromsplash == false) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();

            Get.offAll(Login());
          }
          snackBar("Failed", "Unauthorized");
        }
      } else {
        if (fromsplash == false) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          Get.offAll(Login());
          // Get.put(FloorController()).fetchFloorTable(false, "");
          Get.put(UtcTimeController());
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAll(Login());
        snackBar("Failed", "Unauthorized");
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
