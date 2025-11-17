import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceHttp {
  final String baseUrl =
      'https://raw.githubusercontent.com/Aswin712/API/refs/heads/main/http.json';

  Future<List<dynamic>> fetchPerfumes() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('[HTTP] Success in ${stopwatch.elapsedMilliseconds} ms');
        return data;
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('[HTTP] Error: $e');
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }
}
