import 'package:get/get.dart';

import '../model/user_model.dart';


class UserController extends GetxController {
  User? user;

  User getUser() {
    return user!;
  }

  void setUser(User userData) {
    user = userData;
    update();
  }
}
