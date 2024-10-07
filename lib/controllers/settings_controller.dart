
import '../views/widgets/export.dart';

class SettingsController extends GetxController {
  RxBool whatsappBilling = false.obs;
  bool whatsappPersonal = false;
  RxBool printPreview = false.obs;


  bool clientInfo = false;
  bool orderBilling = false;
  bool kotOption = false;
  int? bottomNavIndex = 1;
  String? name;
  String? role;
  String? businessType;
  int? restaurantId;

  void toggleWhatsapp(bool value) {
    whatsappBilling.value = value;
    update();
  }

  void toggleWhatsappPersonal(bool value) {
    whatsappPersonal = value;
    update();
  }

  void togglePrintingPreview(bool value) {
    printPreview.value = value;
    update();
  }

  void toggleClientInfo(bool value) {
    clientInfo = value;
    update();
  }

  void toggleOrderBilling(bool value) {
    orderBilling = value;
    update();
  }

  void toggleKotoption(bool value) {
    kotOption = value;
    update();
  }

  void toggleBottomNavIndex(i) {
    bottomNavIndex = i;
    fetchSharedPreference();
    Get.to(() => BottomNav());
    update();
  }

    fetchSharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('name');
    role = pref.getString('role');
    businessType = pref.getString("BusinessType");
    restaurantId = pref.getInt("RestaurantId");
    update();
  }
}
