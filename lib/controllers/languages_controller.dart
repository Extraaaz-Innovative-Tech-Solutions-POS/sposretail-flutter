import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagesController extends GetxController {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'locale': 'en', "country": "US"},
    {'name': 'Hindi', 'locale': 'hi', "country": "IN"},
    {'name': 'Marathi', 'locale': 'mr', "country": "IN"},
  ];

  var selectedLocale = 'en_US'.obs;

  void changeLanguage(lan, code) {
    var locale = Locale(lan, code);
    selectedLocale.value = "${lan}_$code";
    update();
    print(selectedLocale.value);
    Get.updateLocale(locale);
  }
}