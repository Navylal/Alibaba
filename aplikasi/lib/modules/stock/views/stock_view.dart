import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stock_controller.dart';
import 'package:aplikasi/data/models/stock_item.dart';

import 'add/add_perfume_view.dart';
import 'add/add_ingredient_view.dart';

import 'detail/detail_perfume_view.dart';
import 'detail/detail_ingredient_view.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StockController());
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Management"),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 1,
        actions: [
          ElevatedButton.icon(
            onPressed: () => _showAddItemPopup(context),
            icon: const Icon(Icons.add),
            label: const Text("Add Item"),
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: cs.onPrimary,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSearchBox(context, controller),
            const SizedBox(height: 10),

            Obx(() => _buildTabs(context, controller)),
            const SizedBox(height: 10),

            Expanded(child: Obx(() => _buildList(context, controller))),

            const SizedBox(height: 10),
            Obx(() => Text(
              "Total Stock: ${controller.totalStock}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: cs.onSurface,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context, StockController controller) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      onChanged: controller.searchItems,
      decoration: InputDecoration(
        hintText: "Search items...",
        hintStyle: TextStyle(color: cs.onSurface.withOpacity(0.5)),
        prefixIcon: Icon(Icons.search, color: cs.onSurface),
        filled: true,
        fillColor: cs.surface.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildTabs(BuildContext context, StockController c) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _categoryTab(context, c, "All"),
          _categoryTab(context, c, "perfume"),
          _categoryTab(context, c, "ingredient"),
        ],
      ),
    );
  }

  Widget _categoryTab(BuildContext context, StockController controller, String category) {
    final cs = Theme.of(context).colorScheme;
    final isSelected = controller.selectedCategory.value == category;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeCategory(category),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? cs.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            category.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? cs.onSurface : cs.onSurface.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, StockController controller) {
    final cs = Theme.of(context).colorScheme;

    if (controller.items.isEmpty) {
      return Center(
        child: Text(
          "No items found",
          style: TextStyle(color: cs.onSurface.withOpacity(0.5)),
        ),
      );
    }

    return ListView.builder(
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return GestureDetector(
          onTap: () {
            if (item.type == "perfume")
              Get.to(() => const DetailPerfumeView(), arguments: item);
            else
              Get.to(() => const DetailIngredientView(), arguments: item);
          },
          child: _stockCard(context, item),
        );
      },
    );
  }

Widget _stockCard(BuildContext context, StockItem item) {
  final cs = Theme.of(context).colorScheme;

  String badgeText;
  Color badgeColor;

  if (item.quantity == 0) {
    badgeText = "Out of Stock";
    badgeColor = Colors.red;
  } else if (item.quantity <= 5) {
    badgeText = "Low Stock";
    badgeColor = Colors.orange;
  } else {
    badgeText = "In Stock";
    badgeColor = Colors.blue;
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: cs.shadow.withOpacity(0.1), blurRadius: 4),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: cs.primary.withOpacity(0.15),
          child: Icon(Icons.inventory_2, color: cs.primary),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 11,
                        color: badgeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                item.brand,
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "${item.volume}ml   ${item.quantity} units   ${item.expire}",
                style: TextStyle(color: cs.onSurface),
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Rp${item.price}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: cs.onSurface,
              ),
            ),
            Text(
              item.type,
              style: TextStyle(
                fontSize: 13,
                color: cs.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  void _showAddItemPopup(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Get.generalDialog(
      barrierLabel: 'add-item',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: cs.shadow.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Add New Item",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: cs.onSurface)),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.to(() => const AddPerfumeView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.primary,
                            foregroundColor: cs.onPrimary,
                          ),
                          child: const Text("Perfume"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.to(() => const AddIngredientView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.secondaryContainer,
                            foregroundColor: cs.onSecondaryContainer,
                          ),
                          child: const Text("Ingredient"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
