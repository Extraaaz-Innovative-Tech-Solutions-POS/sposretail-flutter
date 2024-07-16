import 'package:spos_retail/model/common_model.dart';

import '../../views/widgets/export.dart';

class AddModifierContoller extends GetxController {
  final AllModifierListController allModifierListController =
      Get.put(AllModifierListController());
  Future<void> addModifierpost(
      String title, String description, String price) async {
    AddModifier addModifier =
        AddModifier(name: title, price: price, description: description);
    final response = await DioServices.postRequest(
        AppConstant.addmodifiers, addModifier.toJson());
    if (response.statusCode == 200) {
      allModifierListController.getAllModifierList();
      Get.back();
      snackBar("Success", "Added Sucessfully");
      update();
    }
  }
}
