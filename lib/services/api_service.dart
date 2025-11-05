import 'package:dio/dio.dart';

class ApiService {
  late final Dio _dio;
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.github.com/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      ),
    );
  }

  Future<Map<String, dynamic>> getUser(String username) async {
    final response = await _dio.get('users/$username');
    return response.data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getUserRepos(String username) async {
    final response = await _dio.get(
      'users/$username/repos',
      queryParameters: {'per_page': 100, 'sort': 'updated'},
    );
    return response.data as List<dynamic>;
  }
}
