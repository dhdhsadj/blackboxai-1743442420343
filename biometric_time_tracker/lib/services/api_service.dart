import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:biometric_time_tracker/constants.dart';
import 'package:biometric_time_tracker/models/employee.dart';
import 'package:biometric_time_tracker/models/time_record.dart';

class ApiService {
  static final _client = http.Client();

  static Future<String?> _getAuthToken() async {
    return await AuthService.getAuthToken();
  }

  static Future<List<Employee>> getEmployees() async {
    final token = await _getAuthToken();
    final response = await _client.get(
      Uri.parse(ApiEndpoints.employees),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  static Future<void> addEmployee(Employee employee) async {
    final token = await _getAuthToken();
    final response = await _client.post(
      Uri.parse(ApiEndpoints.employees),
      body: jsonEncode(employee.toJson()),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add employee');
    }
  }

  static Future<void> logTime(TimeRecord record) async {
    final token = await _getAuthToken();
    final response = await _client.post(
      Uri.parse(ApiEndpoints.timeLogs),
      body: jsonEncode(record.toJson()),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to log time');
    }
  }

  static Future<List<TimeRecord>> getTimeRecords(String employeeId) async {
    final token = await _getAuthToken();
    final response = await _client.get(
      Uri.parse('${ApiEndpoints.timeLogs}/$employeeId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TimeRecord.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load time records');
    }
  }
}