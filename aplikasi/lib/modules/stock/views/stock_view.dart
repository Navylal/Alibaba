import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stock_controller.dart';
import 'add_item.dart';
import 'detail_product.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StockController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadPerfumesAll();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Management"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Obx(() => Row(
                children: [
                  const Text("Library:", style: TextStyle(color: Colors.black)),
                  Switch(
                    value: controller.useDio.value,
                    onChanged: (val) {
                      controller.useDio.value = val;
                      if (controller.selectedCategory.value == "All") {
                        controller.loadPerfumesAll();
                      }
                    },
                  ),
                  Text(
                    controller.useDio.value ? "Dio" : "HTTP",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                ],
              )),
          ElevatedButton.icon(
            onPressed: () => Get.dialog(const AddItem()),
            icon: const Icon(Icons.add),
            label: const Text("Add Item"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search perfumes...",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 10),

            Obx(() => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _categoryTab(controller, "All"),
                      _categoryTab(controller, "Perfume"),
                      _categoryTab(controller, "Ingredients"),
                    ],
                  ),
                )),
            const SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                if (controller.perfumes.isEmpty) {
                  return const Center(
                    child: Text("No items found",
                        style: TextStyle(color: Colors.grey)),
                  );
                }
                return ListView.builder(
                  itemCount: controller.perfumes.length,
                  itemBuilder: (context, index) {
                    final perfume = controller.perfumes[index];
                    return GestureDetector(
                      onTap: () => Get.dialog(
                          DetailProduct(perfume: perfume, index: index)),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xFFEDE7F6),
                              child: Icon(Icons.inventory_2,
                                  color: Colors.deepPurple),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        perfume["name"] ?? '-',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: (perfume["status"] ?? "")
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "in stock"
                                              ? Colors.blue[100]
                                              : Colors.orange[100],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          perfume["status"] ?? '-',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: (perfume["status"] ?? "")
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "in stock"
                                                ? Colors.blue
                                                : Colors.orange,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(perfume["brand"] ?? "-"),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text("${perfume["volume"] ?? 0}ml"),
                                      const SizedBox(width: 10),
                                      Text("${perfume["stock"] ?? 0} units"),
                                      const SizedBox(width: 10),
                                      Text(perfume["expire"] ?? "-"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Rp${perfume["price"] ?? 0}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(perfume["category"] ?? "-",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 10),
            Obx(() => Text(
                  "Total Stock: ${controller.totalStock}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }

  Widget _categoryTab(StockController controller, String category) {
    final isSelected = controller.selectedCategory.value == category;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectedCategory.value = category;
          if (category == "All") {
            controller.loadPerfumesAll();
          } else {
            controller.loadPerfumesByCategory(category);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            category.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
