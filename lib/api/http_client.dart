import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:n8n_monitor/services/local_storage.dart';

class HttpClient {
  // Cliente singleton
  static final HttpClient _instance = HttpClient._internal();
  factory HttpClient() => _instance;
  HttpClient._internal();

  // Obtener headers con API key
  Map<String, String> _getHeaders({Map<String, String>? additionalHeaders}) {
    final headers = {'Accept': 'application/json'};

    final apiKey = LocalStorage.apiKey;
    if (apiKey != null && apiKey.isNotEmpty) {
      headers['x-n8n-api-key'] = apiKey;
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  // GET request
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final mergedHeaders = _getHeaders(additionalHeaders: headers);

    return await http.get(uri, headers: mergedHeaders);
  }

  // POST request
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = _buildUri(endpoint);
    final mergedHeaders = _getHeaders(additionalHeaders: headers);
    if (body != null && !mergedHeaders.containsKey('Content-Type')) {
      mergedHeaders['Content-Type'] = 'application/json';
    }

    return await http.post(
      uri,
      headers: mergedHeaders,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // PUT request
  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = _buildUri(endpoint);
    final mergedHeaders = _getHeaders(additionalHeaders: headers);
    if (body != null && !mergedHeaders.containsKey('Content-Type')) {
      mergedHeaders['Content-Type'] = 'application/json';
    }

    return await http.put(
      uri,
      headers: mergedHeaders,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // DELETE request
  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint);
    final mergedHeaders = _getHeaders(additionalHeaders: headers);

    return await http.delete(uri, headers: mergedHeaders);
  }

  // PATCH request
  Future<http.Response> patch(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = _buildUri(endpoint);
    final mergedHeaders = _getHeaders(additionalHeaders: headers);
    if (body != null && !mergedHeaders.containsKey('Content-Type')) {
      mergedHeaders['Content-Type'] = 'application/json';
    }

    return await http.patch(
      uri,
      headers: mergedHeaders,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // Construir URI con base URL y query parameters
  Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParameters]) {
    final baseUrl = LocalStorage.url ?? '';
    final url = '$baseUrl/api/v1/$endpoint';
    return Uri.parse(url).replace(queryParameters: queryParameters);
  }

  // Probar conexión con URL y API key específicos (sin usar LocalStorage)
  static Future<bool> testConnection({
    required String baseUrl,
    required String apiKey,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/users');
      final headers = {'Accept': 'application/json', 'x-n8n-api-key': apiKey};

      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 10));

      // Verificar si la respuesta es exitosa (200-299)
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // Error de conexión, timeout, o cualquier excepción
      return false;
    }
  }

  // Método para obtener la URL base actual
  static String? get baseUrl => LocalStorage.url;
}
