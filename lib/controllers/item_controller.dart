

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';
import 'package:http/http.dart' as http;

class ItemController extends GetxController {
  List<ItemModel> items = [];
  RxBool isLoading = false.obs;
  final sectionWisePricing = Get.put(SectionWisePricing());

   Rx<File?> image = Rx<File?>(null);
  final picker = ImagePicker();

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

  Future<void> pickImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final file = File(pickedFile.path);
    if (await file.exists() && (file.path.endsWith('.jpg') || file.path.endsWith('.png') || file.path.endsWith('.jpeg'))) {
      image.value = file; // Set the image using Rx
      print("Image picked: ${image.value}");
    } else {
      print("Picked file is not a valid image.");
    }
  } else {
    print('No image selected.');
  }
}

////////////////////
Future<void> sendToServer(AddItem addItem, String url) async {
  // Fetch token from SharedPreferences
  SharedPreferences pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  // Prepare the multipart request
  var request = http.MultipartRequest('POST', Uri.parse(url));

  // Set headers
  request.headers['Accept'] = 'application/json';
  request.headers['Content-Type'] = 'multipart/form-data'; // Automatically set for multipart
  if (token != null) {
    request.headers['Authorization'] = 'Bearer $token';
  }

  // Add fields
  request.fields['item_name'] = addItem.item_name;
  request.fields['price'] = addItem.price.toString();
  request.fields['discount'] = addItem.discount.toString();
  request.fields['inventory_status'] = addItem.inventory_status;
  request.fields['category_id'] = addItem.category_id.toString();

  if (image != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'item_image', // The name of the field in your API
      image.value!.path,
    ));
  }

  // Print for debugging
  print('Request URL: $url');
  print('Authorization Token: $token');

  // Send the request
  var response = await request.send();
    print( "data test.... : ${response  }");


  // print( "datat test : ${response.}");
  // Check the response
  if (response.statusCode == 200) {
    print( "datat test : ${response  }");
    print('Item added successfully!');
    
    
    image.value =null;
      Get.put(CategoryController()).fetchCategories();
        Get.to(() => BottomNav(pageindex: 0));
        update();
  } else {
    print('Failed to add item: ${response.reasonPhrase}');
    print('Status code: ${response.statusCode}');
  }
}
///////////////////////

Future<void> postItemImage(AddItem addItem, String url) async {
  // Fetch token from SharedPreferences
  SharedPreferences pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  // Prepare the multipart request
  var request = http.MultipartRequest('PUT', Uri.parse(url));


  // Set headers
  request.headers['Accept'] = 'application/json';
  request.headers['Content-Type'] = 'multipart/form-data'; // Automatically set for multipart
  if (token != null) {
    request.headers['Authorization'] = 'Bearer $token';
  }

  // Add fields
  request.fields['item_name'] = addItem.item_name;
  request.fields['price'] = addItem.price.toString();
  request.fields['discount'] = addItem.discount.toString();
  request.fields['inventory_status'] = addItem.inventory_status;
  request.fields['category_id'] = addItem.category_id.toString();

  if (image != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'item_image', // The name of the field in your API
      image.value!.path,
    ));
  }

  // Print for debugging
  print('Request URL: $url');
  print('Authorization Token: $token');

  // Send the request
  var response = await request.send();
    print( "data test.... : ${response  }");


  // print( "datat test : ${response.}");
  // Check the response
  if (response.statusCode == 200) {
    print( "datat test : ${response  }");
    print('Item added successfully!');
    
    
    image.value =null;
      Get.put(CategoryController()).fetchCategories();
        Get.to(() => BottomNav(pageindex: 0));
        update();
  } else {
    print('Failed to Update item: ${response.reasonPhrase}');
    print('Status code: ${response.statusCode}');
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
