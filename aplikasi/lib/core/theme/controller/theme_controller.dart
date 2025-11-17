import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/local/shared_prefs_service.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  ThemeData get lightTheme => ThemeData.light(useMaterial3: true);
  ThemeData get darkTheme => ThemeData.dark(useMaterial3: true);

  @override
  void onInit() {
    super.onInit();
    isDark.value = SharedPrefsService.getTheme();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    SharedPrefsService.saveTheme(isDark.value);
  }
}
