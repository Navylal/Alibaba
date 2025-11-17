import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi/data/models/stock_item.dart';

class DetailPerfumeView extends StatelessWidget {
  const DetailPerfumeView({super.key});

  @override
  Widget build(BuildContext context) {
    final StockItem item = Get.arguments;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 380,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: cs.shadow.withOpacity(0.3),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Perfume Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.inventory_2,
                      color: cs.primary, size: 45),
                ),

                const SizedBox(height: 20),

                _row(context, "Name", item.name),
                _row(context, "Brand", item.brand),
                _row(context, "Volume", "${item.volume} ml"),
                _row(context, "Stock", "${item.quantity} unit"),
                _row(context, "Price", "Rp ${item.price}"),
                _row(context, "Cost Price", "Rp ${item.cost}"),
                _row(context, "Expiration Date", item.expire),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: cs.onSurface,
                          side: BorderSide(color: cs.outline),
                        ),
                        child: const Text("Close"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed('/edit-perfume', arguments: item);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.primary,
                          foregroundColor: cs.onPrimary,
                        ),
                        child: const Text("Edit"),
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

  Widget _row(BuildContext context, String label, String value) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: cs.onSurface)),
          Text(value, style: TextStyle(color: cs.onSurface)),
        ],
      ),
    );
  }
}
