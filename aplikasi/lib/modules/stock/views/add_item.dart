import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stock_controller.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final priceController = TextEditingController();
  final volumeController = TextEditingController();
  final stockController = TextEditingController();
  final expireController = TextEditingController();

  String? selectedCategory;

  final List<String> categories = [
    "Perfume",
    "Ingredients",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StockController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add New Item",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                _buildField("Perfume Name", nameController),
                _buildField("Brand", brandController),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: 160,
                      child:
                          _buildField("Volume (ml)", volumeController, isNumber: true),
                    ),
                    SizedBox(
                      width: 160,
                      child:
                          _buildField("Price (Rp)", priceController, isNumber: true),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildField("Stock Quantity", stockController, isNumber: true),
                _buildField("Expiration Date", expireController),
                const SizedBox(height: 10),
                _buildDropdownCategory(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          if (selectedCategory == null) {
                            Get.snackbar("Error", "Please select a category");
                            return;
                          }

                          final stock =
                              int.tryParse(stockController.text.trim()) ?? 0;

                          controller.addPerfume({
                            "name": nameController.text.trim(),
                            "brand": brandController.text.trim(),
                            "price": int.tryParse(priceController.text.trim()) ?? 0,
                            "volume": int.tryParse(volumeController.text.trim()) ?? 0,
                            "stock": stock,
                            "expire": expireController.text.trim(),
                            "category": selectedCategory!,
                            "status": stock > 10 ? "In Stock" : "Low Stock",
                          });

                          Get.back();
                          Get.snackbar("Added", "New item added successfully",
                              snackPosition: SnackPosition.BOTTOM);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("Save",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? "This field is required" : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Category",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            items: categories
                .map((cat) =>
                    DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
            validator: (value) =>
                value == null ? "Please select a category" : null,
          ),
        ],
      ),
    );
  }
}
