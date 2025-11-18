import 'package:aplikasi/data/models/transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionRepository {
  final supa = Supabase.instance.client;

  Future<List<TransactionModel>> getAll() async {
    try {
      final result = await supa
          .from('transactions')
          .select()
          .order('id', ascending: false);

      return result.map((e) => TransactionModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Gagal mengambil transaksi: $e");
    }
  }

  Future<void> addTransaction(TransactionModel trx) async {
    try {
      await supa.from('transactions').insert({
        "user_id": trx.userId,
        "type": trx.type,
        "name": trx.name,
        "qty": trx.qty,
        "unit": trx.unit,
        "price": trx.price,
        "total": trx.total,
        "customer": trx.customer,
        "paid": trx.paid,
        "change": trx.change,
        "date": trx.date.toIso8601String(),
      });
    } catch (e) {
      throw Exception("Gagal menambah transaksi: $e");
    }
  }
  Future<void> updateTransaction({
  required int id,
  required String name,
  required int qty,
  required int unit,
  required int price,
  required String customer,
  required int paid,
  required int change,
}) async {
  try {
    await supa.from('transactions').update({
      "name": name,
      "qty": qty,
      "unit": unit,
      "price": price,
      "customer": customer,
      "paid": paid,
      "change": change,
    }).eq('id', id);
  } catch (e) {
    throw Exception("Gagal update transaksi: $e");
  }
}

Future<void> deleteTransaction(int id) async {
  try {
    await supa.from("transactions").delete().eq("id", id);
  } catch (e) {
    throw Exception("Gagal delete transaksi: $e");
  }
}

}
