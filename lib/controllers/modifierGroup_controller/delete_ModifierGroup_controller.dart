import '../../views/widgets/export.dart';

class DeleteGroupModifierController extends GetxController {
  final GetModifierGroupController getModifierGroupController =
      Get.put(GetModifierGroupController());
  Future<void> deleteModifiercontroller(String id) async {
    final response = await DioServices.delete("${AppConstant.modifier}/${id}");
    if (response.statusCode == 200) {
      snackBar("Success", "Your Modifier is Delete Successfully");
      getModifierGroupController.getModifierGroup();
      update();
    }
  }
}
