import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui_package/src/network/app_api_response.dart';
import 'package:ui_package/src/network/app_network_exception.dart';

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  Future<ApiResponse<dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200) {
        return ApiResponse.success(jsonDecode(response.body));
      } else {
        return ApiResponse.error(response.body);
      }
    } catch (e) {
      throw NetworkException('Something went wrong');
    }
  }

  Future<ApiResponse<dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(jsonDecode(response.body));
      } else {
        return ApiResponse.error(response.body);
      }
    } catch (e) {
      throw NetworkException('Something went wrong');
    }
  }
}
