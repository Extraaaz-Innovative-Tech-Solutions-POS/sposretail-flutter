import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

class ItemController extends GetxController {
  List<ItemModel> items = [];
  RxBool isLoading = false.obs;
  final sectionWisePricing = Get.put(SectionWisePricing());

  @override
  void onInit() {
    super.onInit();
    // Observe the isLoading state and rebuild the UI accordingly
    ever(isLoading, (_) => update());
  }

  // Fetch items from the server
  Future<void> fetchItems() async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.get("items");

      if (response.statusCode == 200) {
        items = (response.data['data'] as List)
            .map<ItemModel>((json) => ItemModel.fromJson(json))
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

  // Post a new item to the server
  Future<void> postItem(AddItem newItem) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.postRequest("items", newItem.toJson());
      print(newItem.toJson());
      if (response.statusCode == 200) {
        print("Item added successfully");
        // print(response.data);
        // Get.put(AllItemsController()).fetchMenu();
        // Get.put(AllItemsController())
        //     .getItemByCategory(int.parse(newItem.category_id.toString()));
        // Get.put(ItemController()).fetchItems();
        Get.put(CategoryController()).fetchCategories();
        Get.to(BottomNav(
          pageindex: 0,
        ));
        update();
      } else {}
    } catch (error) {
      print("Exception: $error");
    } finally {
      isLoading.value = false; // Set loading state to false after API operation
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.delete(
        "items/$id",
      );

      if (response.statusCode == 200) {
        print("Items Delete successfully" + response.data.toString());
        update();
        // If you need to do something after updating (e.g., refetch the updated list), add it here
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    } finally {
      isLoading.value = false; // Set loading state to false after API operation
    }
  }

  // Update an existing item on the server
  Future<void> updateItem(String id, AddItem updatedItem) async {
    print(updatedItem.toJson().toString());
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.put(
        "items/$id",
        updatedItem.toJson(),
      );
      // sectionWisePricing.assignSectionWisePricing(widget.item_id, selectedSectionId, sectionPriceController.text);

      if (response.statusCode == 200) {
        Get.to(BottomNav(
          pageindex: 0,
        ));
        update();
        // If you need to do something after updating (e.g., refetch the updated list), add it here
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
    } finally {
      isLoading.value = false; // Set loading state to false after API operation
    }
  }

  void postCategory(String string, String string2) {}
}
