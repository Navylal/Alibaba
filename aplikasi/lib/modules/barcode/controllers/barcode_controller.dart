import 'package:get/get.dart';

class BarcodeController extends GetxController {
  var scannedCode = ''.obs;

  void scan() {
    scannedCode.value = 'ABC123XYZ'; // Dummy barcode
  }
}
