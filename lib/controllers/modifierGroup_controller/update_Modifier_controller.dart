import 'package:spos_retail/views/widgets/export.dart';

class UpdateModifierGroupController extends GetxController {
  static RxBool isLoading = false.obs;
  final GetModifierGroupController getmodifiergroupController =
      Get.put(GetModifierGroupController());
  Future<void> updatemodifier(String modifierId, String modifierName,
      String modifierDescription, String modifierType, String sectionId) async {
    try {
      isLoading.value = true;
      final response = await DioServices.put("modifierGroups/$modifierId", {
        "name": modifierName,
        "description": modifierDescription,
        "type": "2",
        "section_id": sectionId,
      });

      //  print('object');
      if (response.statusCode == 200) {
        print(response.data['data']);
        getmodifiergroupController.getModifierGroup();
        Get.back();

        update();
        print("Update Successfully");
      }
    } catch (e) {
      print("Unsuccessful $e");
    } finally {
      isLoading.value = false;
    }
  }
}
