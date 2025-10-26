import 'package:get/get.dart';

class CalculatorController extends GetxController {
  var result = 0.0.obs;

  void calculate(double a, double b) {
    result.value = a + b; // Dummy
  }
}
