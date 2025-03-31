import 'package:flutter/material.dart';
import 'package:biometric_time_tracker/screens/login_screen.dart';
import 'package:biometric_time_tracker/screens/main_navigation.dart';
import 'package:biometric_time_tracker/constants.dart';
import 'package:biometric_time_tracker/services/auth_service.dart';

void main() {
  runApp(const BiometricTimeTrackerApp());
}

class BiometricTimeTrackerApp extends StatelessWidget {
  const BiometricTimeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Time Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: AuthService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true
                ? const MainNavigation()
                : const LoginScreen();
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}