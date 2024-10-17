import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesController extends GetxController {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'locale': 'en', "country": "US"},
    {'name': 'Hindi', 'locale': 'hi', "country": "IN"},
    {'name': 'Marathi', 'locale': 'mr', "country": "IN"},
  ];

  var selectedLocale = 'en_US'.obs;

   Locale currentLocale = const Locale('en', 'US');

  void changeLanguage(lan, code) async{
    var locale = Locale(lan, code);
       selectedLocale.value = "${lan}_$code";
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("selectedlanguage", selectedLocale.value);
           currentLocale = locale;
    update();
    print("Language saved: ${selectedLocale.value}");
    Get.updateLocale(locale);
  }


  // Load the saved language from SharedPreferences
  Future<void> loadSavedLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? languageCode = pref.getString("selectedlanguage");
    if (languageCode != null) {
      final parts = languageCode.split('_');
      if (parts.length == 2) {
        changeLanguage(parts[0], parts[1]);
      }
    } else {
      changeLanguage('en', 'US'); // Default language
    }
  }

  // Fetch the current locale
  Locale getCurrentLocale() {
    return currentLocale;
  }
}