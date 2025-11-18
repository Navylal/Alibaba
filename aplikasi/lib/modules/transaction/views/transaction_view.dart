import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import 'new_item_page.dart';
import 'detail_transaction_view.dart';
import 'package:aplikasi/modules/transaction/views/edit_transaction_view.dart';


class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionController>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        centerTitle: true,
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () async {
                    await Get.dialog(
                      const Dialog(
                        insetPadding: EdgeInsets.all(16),
                        backgroundColor: Colors.transparent,
                        child: NewItemPage(),
                      ),
                    );

                    controller.loadTransactions();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("New Item"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Obx(() {
              final totalSales = controller.transactions
                  .where((tx) => tx.type == "sale")
                  .fold<int>(0, (sum, tx) => sum + tx.price);

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: cs.primary,
                      child: Text(
                        "RP",
                        style: TextStyle(
                          color: cs.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Sales",
                          style: TextStyle(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp $totalSales",
                          style: TextStyle(
                            color: cs.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),

            Obx(() {
              final selectedTab = controller.selectedTab.value;

              return Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: cs.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: ["ALL", "SALE", "PURCHASE"].map((tab) {
                    final active = selectedTab == tab;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectedTab.value = tab,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: active ? cs.surface : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: active
                                ? [
                                    BoxShadow(
                                      color: cs.shadow.withOpacity(0.12),
                                      blurRadius: 4,
                                    )
                                  ]
                                : [],
                          ),
                          child: Text(
                            tab,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: active
                                  ? cs.onSurface
                                  : cs.onSurface.withOpacity(0.6),
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

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final selected = controller.selectedTab.value;
                final filtered = controller.transactions.where((tx) {
                  if (selected == "ALL") return true;
                  if (selected == "SALE") return tx.type == "sale";
                  if (selected == "PURCHASE") return tx.type == "purchase";
                  return true;
                }).toList();

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final tx = filtered[index];
                    final isSale = tx.type == "sale";

                    final bgColor = isSale
                        ? cs.primaryContainer.withOpacity(0.35)
                        : cs.secondaryContainer.withOpacity(0.35);

                    final tagColor = isSale ? cs.primary : cs.secondary;

                    return GestureDetector(
                      onTap: () {
                        Get.dialog(
                          TransactionDetailPopup(
                            tx: tx,
                            onEdit: () {
                              Get.back(); 
                              showDialog(
                                context: context,
                                builder: (_) => EditTransactionView(trx: tx),
                              );
                            },

                            onDelete: () async {
                              await controller.deleteTransaction(tx.id);
                              Get.back();
                              controller.loadTransactions();
                            },
                          ),
                          barrierDismissible: true,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: cs.shadow.withOpacity(0.12),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: tagColor,
                              child: Text(
                                "RP",
                                style: TextStyle(
                                  color: cs.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tx.name,
                                    style: TextStyle(
                                      color: cs.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rp ${tx.price}",
                                    style: TextStyle(
                                      color: tagColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("Customer: ${tx.customer}",
                                      style: TextStyle(color: cs.onSurface)),
                                  Text("Unit: Rp ${tx.unit}",
                                      style: TextStyle(color: cs.onSurface)),
                                  Text("Qty: ${tx.qty}",
                                      style: TextStyle(color: cs.onSurface)),
                                  Text(
                                    "Date: ${tx.date.toLocal().toString().split(" ")[0]}",
                                    style: TextStyle(color: cs.onSurface),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: tagColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tx.type.toUpperCase(),
                                style: TextStyle(
                                  color: tagColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
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
