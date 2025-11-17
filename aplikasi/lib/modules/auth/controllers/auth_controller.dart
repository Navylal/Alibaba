import 'package:get/get.dart';
import 'package:aplikasi/core/routes/app_routes.dart';
import 'package:aplikasi/core/services/local/shared_prefs_service.dart';
import 'package:aplikasi/core/services/cloud/supabase_service.dart';

class AuthController extends GetxController {
  final cloud = SupabaseService();

  RxBool isLoading = false.obs;

  Future<void> login({
    required String email,
    required String password,
    
  }) async {
    isLoading.value = true;

    try {
      final response = await cloud.login(email, password);

      if (response.user == null) {
        Get.snackbar("Login Failed", "Email atau password salah");
        isLoading.value = false;
        return;
      }

      final role = await cloud.getRoleByEmail(email);

      await SharedPrefsService.saveEmail(email);
      await SharedPrefsService.saveRole(role);
      await SharedPrefsService.setLoggedIn(true);

      Get.offAllNamed(Routes.home);

    } catch (e) {
      Get.snackbar("Login Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await cloud.logout();
    await SharedPrefsService.logout();
    Get.offAllNamed(Routes.login);
  }

  bool get isLoggedIn => SharedPrefsService.isLoggedIn();

  String get email => SharedPrefsService.getEmail() ?? "-";

  String get role => SharedPrefsService.getRole() ?? "guest";

  String get displayRole {
    switch (role) {
      case "admin":
        return "Administrator";
      case "kasir":
        return "Cashier";
      default:
        return "User";
    }
  }

  
}
