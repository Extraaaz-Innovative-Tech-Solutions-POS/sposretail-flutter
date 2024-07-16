import 'package:spos_retail/views/widgets/export.dart';

class TaxController extends GetxController {
  List<Tax> taxes = [];
  RxBool isLoading = false.obs;
  String? gst;
  String? sgst;

  @override
  void onInit() {
    super.onInit();
    // Observe the isLoading state and rebuild the UI accordingly
    ever(isLoading, (_) => update());
  }

  // Fetch taxes from the server
  Future<void> fetchTaxes() async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.get("tax");

      if (response.statusCode == 200) {
        taxes = (response.data).map<Tax>((json) => Tax.fromJson(json)).toList();
        for (var tax in taxes) {
          if (tax.name == "sgst") {
            sgst = tax.percentage.toString();
          }
          if (tax.name == "GST") {
            gst = tax.percentage.toString();
          }
        }
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

  // Post a new tax to the server
  Future<void> postTax(Tax newTax) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.postRequest("tax", newTax.toJson());

      if (response.statusCode == 200) {
        print("Tax added successfully");
        fetchTaxes();
        // If you need to do something after posting (e.g., refetch the updated list), add it here
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    } finally {
      isLoading.value = false; // Set loading state to false after API operation
    }
  }

  // Update an existing tax on the server
  Future<void> updateTax(String id, Tax updatedTax) async {
    try {
      isLoading.value = true; // Set loading state to true
      final response = await DioServices.put(
        "tax/$id",
        updatedTax.toJson(),
      );

      if (response.statusCode == 200) {
        print("Tax updated successfully");
        print(response.data);
        fetchTaxes();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception: $error");
    } finally {
      isLoading.value = false; // Set loading state to false after API operation
    }
  }
}
