import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  String? selectedType;
  String? selectedParfume;
  final TextEditingController customerCtrl = TextEditingController();
  final TextEditingController qtyCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController totalCtrl = TextEditingController();

  final TransactionController transactionC = Get.find();

  void calculateTotal() {
    final qty = int.tryParse(qtyCtrl.text) ?? 0;
    final price = int.tryParse(priceCtrl.text) ?? 0;
    totalCtrl.text = (qty * price).toString();
  }

  InputDecoration _inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(color: Color(0xFF5C9E63)),
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF5C9E63)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF388E3C), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Record New Transaction",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Transaction Type
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: _inputDecoration("Transaction Type"),
              items: const [
                DropdownMenuItem(value: "sale", child: Text("Sale")),
                DropdownMenuItem(value: "purchase", child: Text("Purchase")),
              ],
              onChanged: (val) => setState(() => selectedType = val),
            ),

            const SizedBox(height: 12),

            // Parfume Selection
            DropdownButtonFormField<String>(
              value: selectedParfume,
              decoration: _inputDecoration("Parfume"),
              items: const [
                DropdownMenuItem(
                  value: "Mykonos - Slow Living 50ml",
                  child: Text("Mykonos - Slow Living 50ml"),
                ),
                DropdownMenuItem(
                  value: "SAFF AND CO - SOTB 100ml",
                  child: Text("SAFF AND CO - SOTB 100ml"),
                ),
              ],
              onChanged: (val) => setState(() => selectedParfume = val),
            ),

            const SizedBox(height: 12),

            // Customer
            TextField(
              controller: customerCtrl,
              decoration:
                  _inputDecoration("Customer", hint: "Nama pelanggan"),
            ),

            const SizedBox(height: 12),

            // Qty + Price
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: qtyCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("Qty"),
                    onChanged: (_) => calculateTotal(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("Unit Price"),
                    onChanged: (_) => calculateTotal(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Total
            TextField(
              controller: totalCtrl,
              readOnly: true,
              decoration: _inputDecoration("Total"),
            ),

            const SizedBox(height: 20),

            // Submit
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedType == null ||
                      selectedParfume == null ||
                      customerCtrl.text.isEmpty ||
                      qtyCtrl.text.isEmpty ||
                      priceCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  final tx = {
                    "type": selectedType!,
                    "name": selectedParfume!,
                    "customer": customerCtrl.text,
                    "qty": int.parse(qtyCtrl.text),
                    "unit": int.parse(priceCtrl.text),
                    "price": int.parse(totalCtrl.text),
                    "date": DateTime.now().toString().split(' ')[0],
                  };

                  transactionC.addTransaction(tx);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C9E63),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Record Transaction",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
