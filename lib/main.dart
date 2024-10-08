import 'package:spos_retail/views/widgets/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UtcTimeController());
  MyTranslations myTranslations = MyTranslations();
   await myTranslations.loadTranslations();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (c) {
      return GetMaterialApp(
        translations: MyTranslations(),
        locale: const Locale('en', 'US'), 
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('mr', 'IN'),
  ],
        title: 'sPOS',
        debugShowCheckedModeBanner: false,
        theme: c.lightTheme ? light : dark,
        home: const SplashScreen(),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, 
        GlobalWidgetsLocalizations.delegate,   
        GlobalCupertinoLocalizations.delegate, // Optional: For iOS
      ],
      );
    });
  }
}

  