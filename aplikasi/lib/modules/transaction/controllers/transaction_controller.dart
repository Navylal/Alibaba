import 'package:get/get.dart';

class TransactionController extends GetxController {
  var selectedTab = "ALL".obs;
  var selectedIndex = RxnInt();

  var transactions = <Map<String, dynamic>>[
    {
      "type": "sale",
      "name": "Mykonos - Slow Living 50ml",
      "price": 500000,
      "customer": "Ilal",
      "qty": 2,
      "unit": 250000,
      "date": "2025-10-01"
    },
    {
      "type": "sale",
      "name": "SAFF AND CO - SOTB 100ml",
      "price": 500000,
      "customer": "Rezky",
      "qty": 2,
      "unit": 250000,
      "date": "2025-10-01"
    },
    {
      "type": "purchase",
      "name": "Mykonos - Slow Living",
      "price": 200000,
      "customer": "Dula",
      "qty": 1,
      "unit": 200000,
      "date": "2025-10-01"
    },
  ].obs;

  void addTransaction(Map<String, dynamic> newTx) {
    transactions.insert(0, newTx);
  }

  int get todaySales => transactions
      .where((tx) => tx["type"] == "sale")
      .fold(0, (sum, tx) => sum + (tx["price"] as int));
}
