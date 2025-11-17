import 'package:get/get.dart';
import '../../transaction/controllers/transaction_controller.dart';
import '../../stock/controllers/stock_controller.dart';

class HomeController extends GetxController {
  var username = "User".obs;
  var stockCount = 0.obs;
  var todaySales = "0".obs;

  late final StockController stockController;
  late final TransactionController txController;

  @override
  void onInit() {
    super.onInit();
    stockController = Get.find<StockController>();
    txController = Get.find<TransactionController>();

    ever(stockController.items, (_) => updateStockCount());
    ever(txController.transactions, (_) => updateTodaySales());

    updateStockCount();
    updateTodaySales();
  }

  void updateStockCount() {
    stockCount.value = stockController.totalStock;
  }

  void updateTodaySales() {
    final total = txController.transactions
        .where((tx) => tx.type == "sale")
        .fold<int>(0, (sum, tx) => sum + tx.price);

    todaySales.value = total.toString();
  }
}
