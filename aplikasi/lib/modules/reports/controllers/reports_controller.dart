import 'package:get/get.dart';

class ReportsController extends GetxController {
  var reportGenerated = false.obs;

  void generateReport() {
    reportGenerated.value = true;
  }
}
