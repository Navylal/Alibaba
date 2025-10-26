import 'package:get/get.dart';

class AccountController extends GetxController {
  var username = 'Ali'.obs;

  void changeName(String name) {
    username.value = name;
  }
}
