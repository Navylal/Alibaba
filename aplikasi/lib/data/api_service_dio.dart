import 'dart:convert';
import 'package:dio/dio.dart';

class ApiServiceDio {
  final Dio dio = Dio();

  final String baseUrl =
      'https://raw.githubusercontent.com/Navylal/API/main/parfume_dio.json';

  ApiServiceDio() {
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: false,
      responseHeader: false,
    ));
  }

  Future<List<dynamic>> fetchPerfumes() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await dio.get(baseUrl);

      // Tambahkan ini biar aman untuk semua tipe data
      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      print('[DIO] Success in ${stopwatch.elapsedMilliseconds} ms');
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
}
