import 'dart:convert';
import 'package:http/http.dart' as http;

// constants
import '../constants/config.dart';

class HttpService {
  static const String _baseUrl = apiBaseUrl;

  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  HttpService._internal();

  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _defaultHeaders,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, dynamic body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _defaultHeaders,
      body: json.encode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, [dynamic body]) async {
    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _defaultHeaders,
      body: body != null ? json.encode(body) : null,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _defaultHeaders,
    );

    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        throw Exception('Solicitud incorrecta: ${response.body}');
      case 401:
        throw Exception('No autorizado: ${response.body}');
      case 403:
        throw Exception('Prohibido: ${response.body}');
      case 404:
        throw Exception('No encontrado: ${response.body}');
      default:
        throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
