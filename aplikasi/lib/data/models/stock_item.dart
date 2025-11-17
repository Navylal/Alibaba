import 'package:hive/hive.dart';

part 'stock_item.g.dart';

@HiveType(typeId: 1)
class StockItem {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  String name;

  @HiveField(3)
  String brand;

  @HiveField(4)
  String volume;

  @HiveField(5)
  int quantity;

  @HiveField(6)
  double price;

  @HiveField(7)
  double cost;

  @HiveField(8)
  String expire;

  StockItem({
    required this.id,
    required this.type,
    required this.name,
    required this.brand,
    required this.volume,
    required this.quantity,
    required this.price,
    required this.cost,
    required this.expire,
  });

  StockItem copyWith({
    String? id,
    String? type,
    String? name,
    String? brand,
    String? volume,
    int? quantity,
    double? price,
    double? cost,
    String? expire,
  }) {
    return StockItem(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      volume: volume ?? this.volume,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      expire: expire ?? this.expire,
    );
  }
}
