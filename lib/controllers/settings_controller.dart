import 'package:spos_retail/views/widgets/export.dart';

class SettingsController extends GetxController{

  RxBool whatsappBilling = false.obs;
  bool whatsappPersonal = false;
  RxBool printPreview = false.obs;

  void toggleWhatsappPersonal(bool value) {
    whatsappPersonal = value;
    update();
  }

}