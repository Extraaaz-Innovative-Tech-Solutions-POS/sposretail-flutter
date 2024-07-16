import 'package:spos_retail/model/common_model.dart';
import '../../views/widgets/export.dart';

class AddModifierGroupController extends GetxController {
  Future<void> addModifierGroupPost(
      String name, String description, int type, int sectionId) async {
    AddModifierGroup modifierGroup = AddModifierGroup(
        name: name, description: description, type: type, sectionId: sectionId);
    final GetModifierGroupController getModifierGroupController =
        Get.put(GetModifierGroupController());
    final response = await DioServices.postRequest(
        AppConstant.modifier, modifierGroup.toJson());

    try {
      if (response.statusCode == 200) {
        getModifierGroupController.getModifierGroup();
        Get.back();
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
