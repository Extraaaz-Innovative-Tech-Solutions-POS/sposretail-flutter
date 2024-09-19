import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'message': 'Welcome to our app!',
        },
        'es_ES': {
          'hello': '¡Hola!',
          'message': '¡Bienvenido a nuestra aplicación!',
        },
        'fr_FR': {
          'hello': 'Bonjour!',
          'message': 'Bienvenue dans notre application!',
        },
      };
}
