import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:biometric_time_tracker/constants.dart';
import 'package:biometric_time_tracker/widgets/time_clock_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  DateTime? _lastPunchTime;
  String _currentStatus = 'Ready to clock in';
  bool _isAuthenticating = false;

  Future<void> _authenticateAndLogTime(String action) async {
    setState(() => _isAuthenticating = true);
    
    try {
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Authenticate to $action',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );

      if (didAuthenticate) {
        setState(() {
          _lastPunchTime = DateTime.now();
          _currentStatus = '${action.capitalize()} at ${_lastPunchTime!.toLocal()}';
        });
        // TODO: Send to API
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: $e')),
      );
    } finally {
      setState(() => _isAuthenticating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {
              _lastPunchTime = null;
              _currentStatus = 'Ready to clock in';
            }),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fingerprint,
              size: 100,
              color: AppColors.primary,
            ),
            const SizedBox(height: 20),
            Text(
              _currentStatus,
              style: AppTextStyles.headerLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TimeClockButton(
              text: 'Clock In',
              icon: Icons.login,
              onPressed: () => _authenticateAndLogTime('clock in'),
              isLoading: _isAuthenticating,
            ),
            const SizedBox(height: 20),
            TimeClockButton(
              text: 'Take Break',
              icon: Icons.coffee,
              onPressed: () => _authenticateAndLogTime('take break'),
              isLoading: _isAuthenticating,
            ),
            const SizedBox(height: 20),
            TimeClockButton(
              text: 'Clock Out',
              icon: Icons.logout,
              onPressed: () => _authenticateAndLogTime('clock out'),
              isLoading: _isAuthenticating,
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}