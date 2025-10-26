import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stock_controller.dart';

class DetailProduct extends StatelessWidget {
  final Map<String, dynamic> perfume;
  final int index;

  const DetailProduct({super.key, required this.perfume, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StockController>();

    return AlertDialog(
      title: Text(perfume["name"]),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Brand: ${perfume["brand"]}"),
          Text("Price: Rp${perfume["price"]}"),
          Text("Volume: ${perfume["volume"]}ml"),
          Text("Stock: ${perfume["stock"]} units"),
          Text("expire: ${perfume["expire"]}"),
          Text("Category: ${perfume["category"]}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.deletePerfume(index);
            Get.back();
            Get.snackbar("Deleted", "Perfume has been removed",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red[100]);
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Get.dialog(EditPerfumeForm(perfume: perfume, index: index));
          },
          child: const Text("Edit"),
        ),
        TextButton(onPressed: () => Get.back(), child: const Text("Close")),
      ],
    );
  }
}

class EditPerfumeForm extends StatelessWidget {
  final Map<String, dynamic> perfume;
  final int index;

  const EditPerfumeForm({super.key, required this.perfume, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StockController>();

    final nameController = TextEditingController(text: perfume["name"]);
    final brandController = TextEditingController(text: perfume["brand"]);
    final priceController =
        TextEditingController(text: perfume["price"].toString());
    final volumeController =
        TextEditingController(text: perfume["volume"].toString());
    final stockController =
        TextEditingController(text: perfume["stock"].toString());
    final expireController = TextEditingController(text: perfume["expire"]);
    final categoryController =
        TextEditingController(text: perfume["category"]);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Edit Product",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                      child: _buildField("Volume (ml)", volumeController,
                          isNumber: true)),
                  SizedBox(
                      width: 160,
                      child: _buildField("Price (Rp)", priceController,
                          isNumber: true)),
                ],
              ),
              const SizedBox(height: 10),
              _buildField("Stock Quantity", stockController, isNumber: true),
              _buildField("Expiration Date", expireController),
              _buildField("Category", categoryController),
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
                        if (nameController.text.isEmpty ||
                            brandController.text.isEmpty) {
                          Get.snackbar("Error", "Please fill all fields");
                          return;
                        }

                        final stock =
                            int.tryParse(stockController.text.trim()) ?? 0;

                        controller.updatePerfume(index, {
                          "name": nameController.text,
                          "brand": brandController.text,
                          "price":
                              int.tryParse(priceController.text.trim()) ?? 0,
                          "volume":
                              int.tryParse(volumeController.text.trim()) ?? 0,
                          "stock": stock,
                          "expire": expireController.text.trim(),
                          "category": categoryController.text.trim(),
                          "status": stock > 10 ? "In Stock" : "Low Stock",
                        });

                        Get.back();
                        Get.snackbar("Updated", "Perfume updated successfully",
                            snackPosition: SnackPosition.BOTTOM);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Save Changes",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
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
          TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
