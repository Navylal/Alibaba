import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'modules/home/bindings/home_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alibaba Perfume Management',
      debugShowCheckedModeBanner: false,

      // Gunakan routing dari GetX
      initialRoute: Routes.home,
      initialBinding: HomeBinding(), // binding pertama kali
      getPages: AppPages.pages,

      // Optional: tema biar lebih konsisten
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
