import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi/data/models/stock_item.dart';
import '../../controllers/stock_controller.dart';

class EditPerfumeView extends StatelessWidget {
  const EditPerfumeView({super.key});

  @override
  Widget build(BuildContext context) {
    final StockItem item = Get.arguments;
    final controller = Get.find<StockController>();
    final cs = Theme.of(context).colorScheme;

    final nameC = TextEditingController(text: item.name);
    final brandC = TextEditingController(text: item.brand);
    final volumeC = TextEditingController(text: item.volume);
    final stockC = TextEditingController(text: item.quantity.toString());
    final priceC = TextEditingController(text: item.price.toString());
    final costC = TextEditingController(text: item.cost.toString());
    final expireC = TextEditingController(text: item.expire);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Edit Perfume'),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _input(context, "Perfume Name", nameC),
              _input(context, "Brand", brandC),

              Row(
                children: [
                  Expanded(
                      child: _input(context, "Volume (ml)", volumeC,
                          keyboard: TextInputType.number)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _input(context, "Stock", stockC,
                          keyboard: TextInputType.number)),
                ],
              ),

              Row(
                children: [
                  Expanded(
                      child: _input(context, "Price (Rp)", priceC,
                          keyboard: TextInputType.number)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _input(context, "Cost Price (Rp)", costC,
                          keyboard: TextInputType.number)),
                ],
              ),

              _input(context, "Expiration Date", expireC),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final updated = StockItem(
                          id: item.id,
                          type: "perfume",
                          name: nameC.text,
                          brand: brandC.text,
                          volume: volumeC.text,
                          quantity: int.tryParse(stockC.text) ?? 0,
                          price: double.tryParse(priceC.text) ?? 0.0,
                          cost: double.tryParse(costC.text) ?? 0.0,
                          expire: expireC.text,
                        );

                        controller.updateItem(updated);
                        Get.back();
                      },
                      child: const Text("Save Changes"),
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

  Widget _input(BuildContext context, String label, TextEditingController c,
      {TextInputType keyboard = TextInputType.text}) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: cs.onSurface)),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          keyboardType: keyboard,
          decoration: InputDecoration(
            filled: true,
            fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.3),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
