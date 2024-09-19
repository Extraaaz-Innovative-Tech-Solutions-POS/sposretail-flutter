import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyTranslations extends Translations {
  // Create a static map to store all loaded translations
  static Map<String, Map<String, String>> _translations = {};

  @override
  Map<String, Map<String, String>> get keys => _translations;

  Future<void> loadTranslations() async {
    final enJson = await _loadJson('assets/languages/en.json');
    final hiJson = await _loadJson('assets/languages/hi.json');
    final mrJson = await _loadJson('assets/languages/mr.json');

    _translations['en_US'] = enJson;
    _translations['hi_IN'] = hiJson;
    _translations['mr_IN'] = mrJson;
  }


  Future<Map<String, String>> _loadJson(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }
}

