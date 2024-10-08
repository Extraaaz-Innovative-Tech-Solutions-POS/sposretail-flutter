import 'package:spos_retail/views/widgets/export.dart';

void main() {
  Get.put(UtcTimeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (c) {
      return GetMaterialApp(
        title: 'sPOS',
        debugShowCheckedModeBanner: false,
        theme: c.lightTheme ? light : dark,
        home: const SplashScreen(),
      );
    });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkToken();
  }

  Future<void> _checkToken() async {
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
        launchApp('com.example.myapplication');
        Get.put(AuthController()).login(username, password, fromsplash: true);
      });
    } else {
      prefs.setInt("Currentdate", currentdate);
      Future.delayed(const Duration(seconds: 3), () {
        launchApp('com.example.myapplication');
        Get.to(Login());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: bgImageDecor,
        child: Center(
            child: Lottie.asset('assets/Animation/splashScreen.json',
                repeat: false)
                ),
      ),
    );
  }

  void launchApp(String packageName) async {
    if (await DeviceApps.isAppInstalled(packageName)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var existingPrinter = prefs.get("BillingPrinter");
      if (existingPrinter != null) {
        await DeviceApps.openApp(packageName);
      } else {
        print("Printer is not connected");
      }
    } else {
      print('App is not installed.');
      // Handle the case where the app is not installed
    }
  }
}
  