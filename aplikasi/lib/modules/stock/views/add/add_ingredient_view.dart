import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi/data/models/stock_item.dart';
import '../../controllers/stock_controller.dart';

class AddIngredientView extends StatelessWidget {
  const AddIngredientView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StockController>();
    final cs = Theme.of(context).colorScheme;

    final nameC = TextEditingController();
    final brandC = TextEditingController();
    final volumeC = TextEditingController();
    final priceC = TextEditingController();
    final costC = TextEditingController();
    final expireC = TextEditingController();

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: cs.shadow.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Ingredient",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 20),

              _input(context, "Ingredient Name", nameC),
              _input(context, "Brand", brandC),
              _input(context, "Volume (ml)", volumeC,
                  keyboard: TextInputType.number),

              Row(
                children: [
                  Expanded(child: _input(context, "Price (Rp)", priceC, keyboard: TextInputType.number)),
                  const SizedBox(width: 10),
                  Expanded(child: _input(context, "Cost Price (Rp)", costC, keyboard: TextInputType.number)),
                ],
              ),

              _input(context, "Expiration Date", expireC),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: cs.onSurface,
                        side: BorderSide(color: cs.outline),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addItem(
                          StockItem(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            type: "ingredient",
                            name: nameC.text,
                            brand: brandC.text,
                            volume: volumeC.text,
                            quantity: 0,
                            price: double.tryParse(priceC.text) ?? 0,
                            cost: double.tryParse(costC.text) ?? 0,
                            expire: expireC.text,
                          ),
                        );
                        Get.back();
                      },
                      child: const Text("Save"),
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

  Widget _input(
    BuildContext context,
    String label,
    TextEditingController c, {
    TextInputType keyboard = TextInputType.text,
  }) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: cs.onSurface)),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          keyboardType: keyboard,
          style: TextStyle(color: cs.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.25),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
