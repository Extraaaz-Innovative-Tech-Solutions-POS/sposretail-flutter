import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/staff/staffsettingsUI.dart';
import '../constants/constant.dart';
import '../model/staff_model.dart';
import '../services/dio_services.dart';

class StaffController extends GetxController {
  List<Staff> users = [];

  Future<void> fetchUsers() async {
    try {
      final response = await DioServices.get("staff");

      if (response.statusCode == 200) {
        users = response.data['data']
            .map<Staff>((json) => Staff.fromJson(json))
            .toList();

        update();
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Exception: $error");
      }
    }
  }

  Future<void> createUser(AddStaff staff) async {
    try {
      if (staff.phone.length == 10) {
        final response = await DioServices.postRequest("staff", staff.toJson());

        if (response.statusCode == 200) {
          Get.snackbar("Success", "User Added successfully",
              snackPosition: SnackPosition.BOTTOM);
          Get.to(const StaffSettings());
          fetchUsers();
        } else {
          Map<String, dynamic> responseData = response.data;
          Get.snackbar("Error", "${responseData['error']}",
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        snackBar("Failed", "Enter valid Phone number");
      }
    } catch (error) {
      Get.snackbar("Error", "Error occured ",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> updateUser(String staffid, String staffname, String staffemail,
      String staffphone, String staffrole) async {
    try {
      if (staffphone.length == 10) {
        final response = await DioServices.put("staff/$staffid", {
          "name": staffname,
          "email": staffemail,
          "phone": staffphone,
          "role": staffrole,
        });

        print(response.statusCode);
        if (response.statusCode == 200) {
          update();
          fetchUsers();
          Get.back();
          snackBar("Success", "Updated Sucessfully");
        }
      } else {
        snackBar("Failed", "Enter valid Phone number");
      }

      // final response = await DioServices.put("staff/$staffid", {
      //   "name": staffname,
      //   "email": staffemail,
      //   "phone": staffphone,

      //   "role": staffrole,

      // });

      // print(response.statusCode);
      // if (response.statusCode == 200) {
      //   update();
      //   fetchUsers();
      //   Get.back();
      //   snackBar("Success", "Updated Sucessfully");
      // }
    } catch (e) {
      print("Unsuccessful $e");
    }
  }

  // Future<void> updateUser(String userId, Staff updatedStaff) async {
  //   try {
  //     final response =
  //         await DioServices.put("user/$userId", updatedStaff.toJson());

  //     if (response.statusCode == 200) {
  //       Get.snackbar("Success", "User Updated successfully",
  //           snackPosition: SnackPosition.BOTTOM);
  //       fetchUsers();
  //       // Handle success as needed
  //     } else {
  //       Map<String, dynamic> responseData = response.data;
  //       Get.snackbar("Error", "${responseData['error']}",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } catch (error) {
  //     Get.snackbar("Error", "Error occurred",
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  Future<void> deleteUser(int userId) async {
    try {
      final response = await DioServices.delete("staff/$userId");

      if (response.statusCode == 200) {
        Get.snackbar("Success", "User deleted successfully",
            snackPosition: SnackPosition.BOTTOM);
        fetchUsers();
      } else if (response.statusCode == 403) {
        Get.snackbar(
            "Unauthorized", "You are not authorized to delete this user",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        Get.snackbar("Error", "Failed to delete user",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar("Error", "An error occurred while deleting user",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }
}
