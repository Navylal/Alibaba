import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_perfume_view.dart';
import 'add_ingredient_view.dart';

class AddItemPopup extends StatelessWidget {
  const AddItemPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 220),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add New Item",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _itemButton(
                  icon: Icons.science,
                  label: "Ingredients",
                  onTap: () {
                    Get.back();
                    Get.dialog(const AddIngredientView(),
                        barrierColor: Colors.transparent);
                  },
                ),

                _itemButton(
                  icon: Icons.local_florist,
                  label: "Perfume",
                  onTap: () {
                    Get.back();
                    Get.dialog(const AddPerfumeView(),
                        barrierColor: Colors.transparent);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _itemButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              "+ $label",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
