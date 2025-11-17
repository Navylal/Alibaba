import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/stock_item.dart';

class HiveService {

  static const String stockBox = 'stock_box';

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    Hive.registerAdapter(StockItemAdapter());
  }

  Future<Box<StockItem>> _openStockBox() async {
    if (Hive.isBoxOpen(stockBox)) {
      return Hive.box<StockItem>(stockBox);
    }
    return await Hive.openBox<StockItem>(stockBox);
  }


  Future<List<StockItem>> getStocks() async {
    final box = await _openStockBox();
    return box.values.toList();
  }

  Future<StockItem?> getStockById(String id) async {
    final box = await _openStockBox();
    return box.get(id);
  }


  Future<void> saveStocks(List<StockItem> items) async {
    final box = await _openStockBox();
    await box.clear();

    for (var item in items) {
      await box.put(item.id, item);
    }
  }

  Future<void> addStock(StockItem item) async {
    final box = await _openStockBox();
    await box.put(item.id, item);
  }

  Future<void> updateStock(StockItem item) async {
    final box = await _openStockBox();
    await box.put(item.id, item);
  }

  Future<void> deleteStock(String id) async {
    final box = await _openStockBox();
    await box.delete(id);
  }


  Future<void> clearAll() async {
    final box = await _openStockBox();
    await box.clear();
  }
}
