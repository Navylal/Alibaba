import 'dart:convert';
import 'package:dio/dio.dart';

class ApiServiceDio {
  final Dio dio = Dio();

  final String baseUrl =
      'https://raw.githubusercontent.com/Aswin712/API/refs/heads/main/Dio.json';

  ApiServiceDio() {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  Future<List<dynamic>> fetchPerfumes() async {
    return _getAll();
  }

  Future<List<dynamic>> fetchIngredients() async {
    return _getAll();
  }

  Future<List<dynamic>> _getAll() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await dio.get(baseUrl);

      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      print('[DIO] Success GET in ${stopwatch.elapsedMilliseconds} ms');
      return data;

    } on DioException catch (e) {
      print('[DIO] Dio Error: ${e.message}');
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      print('[DIO] Unknown Error: $e');
      throw Exception('Unknown Error: $e');
    } finally {
      stopwatch.stop();
    }
  }

  Future<bool> addPerfume(Map<String, dynamic> data) async {
    print("[DIO] SIMULATE ADD PERFUME: $data");
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> addIngredient(Map<String, dynamic> data) async {
    print("[DIO] SIMULATE ADD INGREDIENT: $data");
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> updatePerfume(int id, Map<String, dynamic> data) async {
    print("[DIO] SIMULATE UPDATE PERFUME ID $id : $data");
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> updateIngredient(int id, Map<String, dynamic> data) async {
    print("[DIO] SIMULATE UPDATE INGREDIENT ID $id : $data");
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> deletePerfume(int id) async {
    print("[DIO] SIMULATE DELETE PERFUME ID $id");
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> deleteIngredient(int id) async {
    print("[DIO] SIMULATE DELETE INGREDIENT ID $id");
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
