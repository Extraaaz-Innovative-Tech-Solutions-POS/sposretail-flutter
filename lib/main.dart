import 'package:spos_retail/views/widgets/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UtcTimeController());
      final LanguagesController languagesController = Get.put(LanguagesController());
      // Load saved language
  await languagesController.loadSavedLanguage();
  MyTranslations myTranslations = MyTranslations();
   await myTranslations.loadTranslations();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguagesController>(
      builder: (lc) {
        return GetBuilder<ThemeController>(builder: (c) {
          return GetMaterialApp(
            translations: MyTranslations(),
             locale:   lc.getCurrentLocale(),   
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
            GlobalCupertinoLocalizations.delegate, 
          ],
          
          );
        });
      }
    );
  }
}

  