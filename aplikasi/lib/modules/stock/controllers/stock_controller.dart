import 'package:get/get.dart';
import 'package:aplikasi/data/api_service_http.dart';
import 'package:aplikasi/data/api_service_dio.dart';

class StockController extends GetxController {
  final httpService = ApiServiceHttp();
  final dioService = ApiServiceDio();

  var perfumes = <Map<String, dynamic>>[].obs;
  var selectedCategory = "All".obs;

  // toggle sumber data utama (true = Dio, false = HTTP)
  var useDio = true.obs;

  // =========================
  // LOAD DATA
  // =========================
  Future<void> loadPerfumesAll() async {
    try {
      // hanya ambil dari satu sumber sesuai toggle
      final data = useDio.value
          ? await dioService.fetchPerfumes()
          : await httpService.fetchPerfumes();

      perfumes.assignAll(List<Map<String, dynamic>>.from(data));
      selectedCategory.value = "All";

      Get.snackbar(
        "Loaded",
        "Loaded ${perfumes.length} items from ${useDio.value ? "Dio" : "HTTP"}",
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to load: $e");
    }
  }

  Future<void> loadPerfumesByCategory(String category) async {
    try {
      // ambil data dari kedua sumber
      final dioData =
          List<Map<String, dynamic>>.from(await dioService.fetchPerfumes());
      final httpData =
          List<Map<String, dynamic>>.from(await httpService.fetchPerfumes());

      // gabungkan data tanpa duplikat
      final combined = [...dioData, ...httpData]
          .fold<Map<String, Map<String, dynamic>>>({}, (map, item) {
        final key = "${item["name"]}_${item["brand"]}";
        map[key] = item;
        return map;
      }).values.toList();

      // filter berdasarkan kategori
      final filtered = combined.where((item) {
        final cat = (item["category"] ?? "").toString().toLowerCase();
        return cat == category.toLowerCase();
      }).toList();

      perfumes.assignAll(filtered);
      selectedCategory.value = category;

      Get.snackbar(
        "Category Loaded",
        "Loaded ${perfumes.length} $category items (Dio + HTTP combined)",
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to load category: $e");
    }
  }

  // =========================
  // CRUD
  // =========================
  void addPerfume(Map<String, dynamic> perfume) => perfumes.add(perfume);
  void updatePerfume(int index, Map<String, dynamic> updated) {
    if (index >= 0 && index < perfumes.length) perfumes[index] = updated;
  }

  void deletePerfume(int index) {
    if (index >= 0 && index < perfumes.length) perfumes.removeAt(index);
  }

  int get totalStock =>
      perfumes.fold<int>(0, (sum, item) => sum + ((item["stock"] ?? 0) as num).toInt());
}
