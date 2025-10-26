import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barcode_controller.dart';

class BarcodeView extends GetView<BarcodeController> {
  const BarcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Page')),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Scanned Code: ${controller.scannedCode}',
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.scan,
                  child: const Text('Scan Barcode'),
                ),
              ],
            )),
      ),
    );
  }
}
