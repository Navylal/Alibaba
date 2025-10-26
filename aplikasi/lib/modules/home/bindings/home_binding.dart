import 'package:get/get.dart';
import '../../transaction/controllers/transaction_controller.dart';
import '../../stock/controllers/stock_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Pastikan StockController ada dulu
    Get.lazyPut<StockController>(() => StockController(), fenix: true);

    // Transaksi controller
    Get.lazyPut<TransactionController>(() => TransactionController(), fenix: true);

    // Home controller terakhir (karena tergantung dua di atas)
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
