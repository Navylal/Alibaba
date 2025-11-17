import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../stock/controllers/stock_controller.dart';
import '../controllers/transaction_controller.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  String? selectedType;
  String? selectedParfume;

  final customerC = TextEditingController();
  final qtyC = TextEditingController();
  final unitC = TextEditingController();
  final totalC = TextEditingController();
  final paidC = TextEditingController();
  final changeC = TextEditingController();

  final TransactionController txController = Get.find();
  final StockController stockCrl = Get.find();

  void calculate() {
    final qty = double.tryParse(qtyC.text) ?? 0;
    final unit = double.tryParse(unitC.text) ?? 0;
    final paid = double.tryParse(paidC.text) ?? 0;

    final total = qty * unit;
    final change = paid - total;

    totalC.text = total.round().toString();
    changeC.text = change.round().toString();
  }

  InputDecoration deco(String label, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
      filled: true,
      fillColor: isDark ? Colors.grey[850] : Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            BorderSide(color: isDark ? Colors.greenAccent : Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Material(
        color: Colors.black.withOpacity(0.45),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 420,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Record New Transaction",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      decoration: deco("Transaction Type", context),
                      value: selectedType,
                      items: const [
                        DropdownMenuItem(value: "sale", child: Text("Sale")),
                        DropdownMenuItem(
                            value: "purchase", child: Text("Purchase")),
                      ],
                      onChanged: (v) => setState(() => selectedType = v),
                    ),

                    const SizedBox(height: 12),

                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: const InputDecoration(
                            labelText: "Search perfume...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: deco("Perfume", context),
                      ),
                      items: stockCrl.items
                          .where((p) => p.type == "perfume")
                          .map((p) => "${p.brand} - ${p.name} ${p.volume}ml")
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        selectedParfume = value;

                        final selected = stockCrl.items.firstWhere(
                          (p) =>
                              "${p.brand} - ${p.name} ${p.volume}ml" == value,
                        );

                        unitC.text = selected.price.toString();
                        calculate();
                      },
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: customerC,
                      decoration: deco("Customer (optional)", context),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: qtyC,
                            keyboardType: TextInputType.number,
                            decoration: deco("Qty", context),
                            onChanged: (_) => setState(() => calculate()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: unitC,
                            keyboardType: TextInputType.number,
                            decoration: deco("Unit Price", context),
                            onChanged: (_) => setState(() => calculate()),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: totalC,
                      readOnly: true,
                      decoration: deco("Total", context),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: paidC,
                            keyboardType: TextInputType.number,
                            decoration: deco("Paid", context),
                            onChanged: (_) => setState(() => calculate()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: changeC,
                            readOnly: true,
                            decoration: deco("Change", context),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (selectedType == null ||
                                  selectedParfume == null ||
                                  qtyC.text.isEmpty ||
                                  unitC.text.isEmpty) {
                                Get.snackbar(
                                    "Error", "Please fill all required fields");
                                return;
                              }

                              final qty = int.tryParse(qtyC.text) ?? 0;
                              final unit = double.tryParse(unitC.text) ?? 0.0;
                              final total = qty * unit;

                              await txController.addTransaction(
                                type: selectedType!,
                                name: selectedParfume!,
                                qty: qty,
                                unit: unit.round(),
                                price: total.round(),
                                total: total.round(),
                                customer: customerC.text.isEmpty
                                    ? "-"
                                    : customerC.text,
                                paid: int.tryParse(paidC.text) ?? 0,
                                change: int.tryParse(changeC.text) ?? 0,
                              );

                              final isSale = selectedType == "sale";

                              final stockC = Get.find<StockController>();
                              await stockC.adjustStock(
                                perfumeName: selectedParfume!,
                                qty: qty,
                                isSale: isSale,
                              );

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text("Record Transaction"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
