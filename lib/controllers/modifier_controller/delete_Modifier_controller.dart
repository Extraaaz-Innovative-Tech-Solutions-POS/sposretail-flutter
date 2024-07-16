import '../../views/widgets/export.dart';

class DeleteModifierController extends GetxController {
  final AllModifierListController allModifierListController =
      Get.put(AllModifierListController());
  Future<void> deleteModifiercontroller(String id) async {
    final response = await DioServices.delete("${AppConstant.addmodifiers}/${id}");
    if (response.statusCode == 200) {
      allModifierListController.getAllModifierList();
      update();
      snackBar("Success", "Your Item is Delete Successfully");
    }
  }
}
