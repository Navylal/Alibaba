class TransactionModel {
  final int id;
  final String userId;
  final String type;
  final String name;
  final int qty;
  final int unit;
  final int price;
  final int total;
  final String customer;
  final int paid;
  final int change;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.name,
    required this.qty,
    required this.unit,
    required this.price,
    required this.total,
    required this.customer,
    required this.paid,
    required this.change,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"],
      userId: json["user_id"],
      type: json["type"],
      name: json["name"],
      qty: json["qty"],
      unit: json["unit"],
      price: json["price"],
      total: json["total"],
      customer: json["customer"],
      paid: json["paid"],
      change: json["change"],
      date: DateTime.parse(json["date"]),
    );
  }
}
