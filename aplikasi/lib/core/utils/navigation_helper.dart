import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Nav {
  static void toNamed(String route) {
    Get.to(
      () => GetPageRoute(
        page: () => GetPage(
          name: route,
          page: () => _resolvePage(route),
        ).page(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  static Widget _resolvePage(String route) {
    switch (route) {
      case '/transaction':
        return const Placeholder(); 
      case '/calculator':
        return const Placeholder(); 
      default:
        return const Scaffold(
          body: Center(child: Text('Page not found')),
        );
    }
  }
}
