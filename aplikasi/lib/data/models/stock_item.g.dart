// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockItemAdapter extends TypeAdapter<StockItem> {
  @override
  final int typeId = 1;

  @override
  StockItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockItem(
      id: fields[0] as String,
      type: fields[1] as String,
      name: fields[2] as String,
      brand: fields[3] as String,
      volume: fields[4] as String,
      quantity: fields[5] as int,
      price: fields[6] as double,
      cost: fields[7] as double,
      expire: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StockItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.brand)
      ..writeByte(4)
      ..write(obj.volume)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.cost)
      ..writeByte(8)
      ..write(obj.expire);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
