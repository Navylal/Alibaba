import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import 'new_item_page.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== HEADER =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final newTx = await Navigator.of(context)
                        .push<Map<String, dynamic>>(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Dialog(
                          insetPadding: EdgeInsets.all(16),
                          backgroundColor: Colors.transparent,
                          child: NewItemPage(),
                        ),
                        transitionsBuilder: (context, animation,
                            secondaryAnimation, child) {
                          final fade = Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                          );
                          return FadeTransition(opacity: fade, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 400),
                      ),
                    );
                    if (newTx != null) {
                      controller.addTransaction(newTx);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("New Item"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ===== SUMMARY =====
            Obx(() {
              final totalSales = controller.transactions
                  .where((tx) => tx["type"] == "sale")
                  .fold<int>(0, (sum, tx) => sum + (tx["price"] as int));

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        "RP",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Today's Sales",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          "Rp $totalSales",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),

            const SizedBox(height: 12),

            // ===== FILTER TABS =====
            Obx(() {
              final selectedTab = controller.selectedTab.value;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: ["ALL", "SALE", "PURCHASE"].map((tab) {
                    bool active = selectedTab == tab;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectedTab.value = tab,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                active ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: active
                                ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                                : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            tab,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: active ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),

            const SizedBox(height: 10),

            // ===== TRANSACTION LIST =====
            Expanded(
              child: Obx(() {
                final filtered = controller.transactions.where((tx) {
                  if (controller.selectedTab.value == "ALL") return true;
                  return tx["type"]
                          .toString()
                          .toUpperCase() ==
                      controller.selectedTab.value;
                }).toList();

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final tx = filtered[index];
                    final type = tx["type"].toString();
                    final isSale = type == "sale";

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSale ? Colors.green[50] : Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 3)
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                isSale ? Colors.green : Colors.blue,
                            child: const Text("RP"),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx["name"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Rp ${tx["price"].toString()}",
                                  style: TextStyle(
                                    color: isSale
                                        ? Colors.green
                                        : Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("Customer: ${tx["customer"]}"),
                                Text("Unit: Rp ${tx["unit"]}"),
                                Text("Qty: ${tx["qty"]}"),
                                Text("Date: ${tx["date"]}"),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: (isSale ? Colors.green : Colors.blue)
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              type.toUpperCase(),
                              style: TextStyle(
                                color: isSale ? Colors.green : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
