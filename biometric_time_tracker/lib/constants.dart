import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF3EB489);
  static const secondary = Colors.white;
  static const background = Colors.white;
  static const textDark = Color(0xFF333333);
  static const textLight = Colors.white;
  static const error = Color(0xFFD32F2F);
}

class AppTextStyles {
  static const headerLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textDark,
  );
}

class ApiEndpoints {
  static const baseUrl = 'http://localhost:8080/api';
  static const login = '$baseUrl/auth/login';
  static const register = '$baseUrl/auth/register';
  static const employees = '$baseUrl/employees';
  static const timeLogs = '$baseUrl/time-logs';
  static const reports = '$baseUrl/reports';
}