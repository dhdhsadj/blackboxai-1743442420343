import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:biometric_time_tracker/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static final _client = http.Client();

  static Future<void> login(String email, String password) async {
    final response = await _client.post(
      Uri.parse(ApiEndpoints.login),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'auth_token', value: data['token']);
      await _storage.write(key: 'company_id', value: data['companyId']);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  static Future<void> register(
    String companyName,
    String email,
    String password,
    String cnpj,
  ) async {
    final response = await _client.post(
      Uri.parse(ApiEndpoints.register),
      body: jsonEncode({
        'companyName': companyName,
        'email': email,
        'password': password,
        'cnpj': cnpj,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  static Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }

  static Future<void> logout() async {
    await _storage.deleteAll();
  }

  static Future<bool> isLoggedIn() async {
    return await _storage.containsKey(key: 'auth_token');
  }
}