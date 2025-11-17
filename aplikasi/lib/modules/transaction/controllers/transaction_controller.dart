import 'package:get/get.dart';
import 'package:aplikasi/data/models/transaction_model.dart';
import 'package:aplikasi/data/repositories/transaction_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionController extends GetxController {
  final repo = TransactionRepository();

  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxBool isLoading = false.obs;

  var selectedTab = "ALL".obs;
  var selectedIndex = RxnInt();

  @override
  void onInit() {
    loadTransactions();
    super.onInit();
  }

  Future<void> loadTransactions() async {
    isLoading.value = true;

    try {
      final data = await repo.getAll();
      transactions.value = data;
    } catch (e) {
      print("Error loadTransactions: $e");
    }

    isLoading.value = false;
  }

  Future<void> addTransaction({
    required String type,
    required String name,
    required int qty,
    required int unit,
    required int price,
    required int total,
    required String customer,
    required int paid,
    required int change,
  }) async {
    try {
      final uid = Supabase.instance.client.auth.currentUser!.id;

      final trx = TransactionModel(
        id: 0,
        userId: uid,
        type: type,
        name: name,
        qty: qty,
        unit: unit,
        price: price,
        total: total,
        customer: customer.isEmpty ? "-" : customer,
        paid: paid,
        change: change,
        date: DateTime.now(),
      );

      await repo.addTransaction(trx);
      await loadTransactions();
    } catch (e) {
      print("Error addTransaction: $e");
    }
  }
}
