
import '../views/widgets/export.dart';

class SettingsController extends GetxController {
  RxBool whatsappBilling = false.obs;
  bool whatsappPersonal = false;
  RxBool printPreview = false.obs;


  bool clientInfo = false;
  bool orderBilling = false;
  //bool kotOption = false;
  int? bottomNavIndex = 1;
  String? name;
  String? role;
  String? printerName;
  String? restaurantName;
  String? address;
  String? phone;
  int? invoiceType;
  String? businessType;
  int? restaurantId;
  int? unitValue;

  void toggleUnit(v) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    unitValue = v;
    update();
    pref.setInt('unit', unitValue!);
  }

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

  // void toggleKotoption(bool value) {
  //   kotOption = value;
  //   update();
  // }

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
    unitValue = pref.getInt("unit");
    printerName = pref.getString("BillingPrinter");
    restaurantName = pref.getString("RestaurantName");
    address = pref.getString("Address");
    phone = pref.getString("Phone");
    invoiceType = pref.getInt("InchesType");
    update();
  }

  void launchApp(String packageName) async {
    if (await DeviceApps.isAppInstalled(packageName)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var existingPrinter = prefs.get("BillingPrinter");
      if (existingPrinter != null) {
        await DeviceApps.openApp(packageName);
      } else {
        debugPrint("Printer is not connected");
      }
    } else {
      debugPrint('App is not installed.');
      // Handle the case where the app is not installed
    }
  }

  Future<void> checkToken() async {
    DateTime dateTime = DateTime.now();
    var currentdate = dateTime.day;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool saved = prefs.getBool('saved') ?? false;
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    // Check if token is
    if (saved && username != null && password != null) {
      prefs.setInt("Currentdate", currentdate);
      Future.delayed(const Duration(seconds: 3), () {
        settingsController.launchApp('com.example.myapplication');
        Get.put(AuthController()).login(username, password, fromsplash: true);
      });
    } else {
      prefs.setInt("Currentdate", currentdate);
      Future.delayed(const Duration(seconds: 3), () {
        settingsController.launchApp('com.example.myapplication');
        Get.to(Login());
      });
    }
  }
}
