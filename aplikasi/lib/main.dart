import 'package:aplikasi/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/services/local/shared_prefs_service.dart';
import 'core/theme/controller/theme_controller.dart';
import 'core/theme/app_theme.dart';
import 'modules/auth/bindings/auth_binding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import 'package:hive_flutter/hive_flutter.dart';
import 'package:aplikasi/data/models/stock_item.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hyegoyozbcpkgznveanc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5ZWdveW96YmNwa2d6bnZlYW5jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM0MDgzNTMsImV4cCI6MjA3ODk4NDM1M30.c9Ob_08omGbjHDSMWyOf_r-hcluGElZYPrskzziJhEY',
  );


  await SharedPrefsService.init();

  await Hive.initFlutter();

  Hive.registerAdapter(StockItemAdapter());

  await Hive.openBox<StockItem>('stock_box');
  await Hive.openBox('transactions');

  Get.put(ThemeController());
  Get.put(AuthController(), permanent: true);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeC = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        title: 'Alibaba Perfume Management',
        debugShowCheckedModeBanner: false,

        initialRoute: Routes.login,

        getPages: AppPages.pages,

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeC.themeMode,
      );
    });
  }
}
