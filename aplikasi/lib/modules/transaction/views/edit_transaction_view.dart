import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import 'package:aplikasi/data/models/transaction_model.dart';

class EditTransactionView extends StatefulWidget {
  final TransactionModel trx;

  const EditTransactionView({super.key, required this.trx});

  @override
  State<EditTransactionView> createState() => _EditTransactionViewState();
}

class _EditTransactionViewState extends State<EditTransactionView> {
  final nameC = TextEditingController();
  final qtyC = TextEditingController();
  final unitC = TextEditingController();
  final priceC = TextEditingController();
  final customerC = TextEditingController();
  final paidC = TextEditingController();
  final changeC = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameC.text = widget.trx.name;
    qtyC.text = widget.trx.qty.toString();
    unitC.text = widget.trx.unit.toString();
    priceC.text = widget.trx.price.toString();
    customerC.text = widget.trx.customer;
    paidC.text = widget.trx.paid.toString();
    changeC.text = widget.trx.change.toString();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionController>();
    final cs = Theme.of(context).colorScheme;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: cs.surface,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Transaction",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            _field("Name", nameC),
            _field("Qty", qtyC, number: true),
            _field("Unit Price", unitC, number: true),
            _field("Total Price", priceC, number: true),
            _field("Customer", customerC),
            _field("Paid", paidC, number: true),
            _field("Change", changeC, number: true),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // DELETE BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.error,
                    foregroundColor: cs.onError,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                  ),
                  onPressed: () async {
                    await controller.deleteTransaction(widget.trx.id);
                    Get.back();
                  },
                  child: const Text("DELETE"),
                ),

                // SAVE BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                  ),
                  onPressed: () async {
                    await controller.updateTransaction(
                      id: widget.trx.id,
                      name: nameC.text,
                      qty: int.parse(qtyC.text),
                      unit: int.parse(unitC.text),
                      price: int.parse(priceC.text),
                      customer: customerC.text,
                      paid: int.parse(paidC.text),
                      change: int.parse(changeC.text),
                    );
                    Get.back();
                  },
                  child: const Text("SAVE"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FIELD GENERATOR DENGAN WARNA OTOMATIS (DARK/LIGHT MODE)
  // ============================================================
  Widget _field(String label, TextEditingController c,
      {bool number = false}) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: cs.onSurfaceVariant),
          filled: true,
          fillColor: cs.surfaceVariant, // 🔥 mendukung light & dark theme
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: cs.outline.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: cs.outline.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: cs.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
