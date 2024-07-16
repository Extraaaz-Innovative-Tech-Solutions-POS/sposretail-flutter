import 'package:get/get.dart';
import 'package:spos_retail/constants/constant.dart';
import 'package:spos_retail/controllers/all_items_controller.dart';
import '../model/category_item_model.dart';
import '../services/dio_services.dart';

class CategoryController extends GetxController {
  List<CategoryModel> menu = [];
  static RxBool isLoading = false.obs;
  RxString itemnameUpdatecontroller = "".obs;
  RxInt itemId = 0.obs;
  RxString itemDescriptionController = "".obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Observe the isLoading state and rebuild the UI accordingly

  // }

  //* Fetch categories from the server
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.get("category");

      if (response.statusCode == 200) {
        menu = (response.data['data'] as List)
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    } finally {
      isLoading.value = false; // Set loading state to false after API operation
    }
  }

  //* Post a new category to the server
  Future<void> postCategory(String name, String description) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.postRequest("category", {
        "category_name": name,
        "description": description,
      });

      if (response.statusCode == 200) {
        fetchCategories();
        Get.back();

        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.delete("category/$categoryId");

      if (response.statusCode == 200) {
        Get.snackbar("Done", "Category Deleted Successfully");
        Get.put(AllItemsController()).fetchMenu(0);
        Get.put(CategoryController()).fetchCategories();
        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCategory(
      String categoryId, String name, String description, context) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.put("category/$categoryId", {
        "category_name": name,
        "description": description,
      });

      if (response.statusCode == 200) {
        // Get.snackbar("Done", "Category Updated Successfully");

        fetchCategories();
        Get.back();
        update();
        snackBarBottom("Success", "Update Sucessfully", context);
      } else {}
    } catch (error) {
    } finally {
      isLoading.value = false;
    }
  }
}
