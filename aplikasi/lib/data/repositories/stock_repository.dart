import 'package:hive/hive.dart';
import '../models/stock_item.dart';

class StockRepository {
  static const String boxName = 'stock_box';

  Future<Box<StockItem>> _openBox() async {
    return await Hive.openBox<StockItem>(boxName);
  }

  Future<List<StockItem>> getLocalStocks() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> saveLocalStocks(List<StockItem> items) async {
    final box = await _openBox();
    await box.clear();
    for (final item in items) {
      await box.put(item.id, item);
    }
  }

  Future<void> addStock(StockItem item) async {
    final box = await _openBox();
    await box.put(item.id, item);
  }

  Future<void> updateStock(StockItem item) async {
    final box = await _openBox();
    await box.put(item.id, item);
  }

  Future<void> deleteStock(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
