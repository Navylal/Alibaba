import 'package:get/get.dart';
import '../../../data/models/stock_item.dart';
import '../../../data/repositories/stock_repository.dart';

class StockController extends GetxController {
  final StockRepository _repo = StockRepository();

  RxList<StockItem> items = <StockItem>[].obs;
  RxList<StockItem> allItems = <StockItem>[].obs;

  var selectedCategory = "All".obs;
  var searchQuery = "".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocal();
  }

  Future<void> loadLocal() async {
    isLoading.value = true;
    final data = await _repo.getLocalStocks();
    allItems.assignAll(data);
    applyFilters();
    isLoading.value = false;
  }

  void applyFilters() {
    List<StockItem> filtered = allItems.toList();

    if (selectedCategory.value != "All") {
      filtered =
          filtered.where((item) => item.type == selectedCategory.value).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      final q = searchQuery.value.toLowerCase();
      filtered = filtered.where((item) {
        return item.name.toLowerCase().contains(q) ||
            item.brand.toLowerCase().contains(q);
      }).toList();
    }

    items.assignAll(filtered);
  }

  void searchItems(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    applyFilters();
  }

  Future<void> addItem(StockItem item) async {
    await _repo.addStock(item);
    await loadLocal();
  }

  Future<void> updateItem(StockItem updated) async {
    await _repo.updateStock(updated);
    await loadLocal();
  }

  Future<void> deleteItem(String id) async {
    await _repo.deleteStock(id);
    await loadLocal();
  }

  int get totalStock {
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  Future<void> adjustStock({
    required String perfumeName,
    required int qty,
    required bool isSale,
  }) async {
    final item = allItems.firstWhere(
      (p) =>
          "${p.brand} - ${p.name} ${p.volume}ml".toLowerCase() ==
          perfumeName.toLowerCase(),
      orElse: () => throw Exception("Item not found in stock list"),
    );

    int newStock = isSale ? (item.quantity - qty) : (item.quantity + qty);
    if (newStock < 0) newStock = 0;

    final updated = item.copyWith(quantity: newStock);

    await updateItem(updated);
  }
}
