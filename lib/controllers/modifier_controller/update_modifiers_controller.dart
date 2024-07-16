import 'package:spos_retail/views/widgets/export.dart';

class UpdateModifier extends GetxController {
  final AllModifierListController allModifierlistController =
      Get.put(AllModifierListController());
  Future<void> updateModifier(String modifierId, String modifierName,
      String modifierPrice, String modifierDescription) async {
    try {
      final response = await DioServices.put("modifiers/$modifierId", {
        "name": modifierName,
        "price": modifierPrice,
        "description": modifierDescription
      });
      if (response.statusCode == 200) {
        update();
        allModifierlistController.getAllModifierList();
        Get.back();
        snackBar("Success", "Updated Sucessfully");
      }
    } catch (e) {
      print("Unsuccessful $e");
    }
  }
}
