import 'package:get/get.dart';
import '../../transaction/controllers/transaction_controller.dart';
import '../../stock/controllers/stock_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockController>(() => StockController(), fenix: true);

    Get.lazyPut<TransactionController>(() => TransactionController(), fenix: true);

    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
