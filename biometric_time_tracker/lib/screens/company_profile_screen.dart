import 'package:flutter/material.dart';
import 'package:biometric_time_tracker/constants.dart';
import 'package:biometric_time_tracker/services/auth_service.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.business,
                  size: 50,
                  color: AppColors.textLight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Company Information',
              style: AppTextStyles.headerLarge,
            ),
            const Divider(height: 20),
            _buildInfoItem('Company Name', 'Tech Solutions Inc.'),
            _buildInfoItem('CNPJ', '12.345.678/0001-90'),
            _buildInfoItem('Address', '123 Business St, City'),
            const SizedBox(height: 20),
            const Text(
              'Settings',
              style: AppTextStyles.headerLarge,
            ),
            const Divider(height: 20),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() => _isDarkMode = value);
                // TODO: Implement theme switching
              },
              activeColor: AppColors.primary,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: AppColors.textLight,
                ),
                onPressed: () async {
                  await AuthService.logout();
                  // TODO: Navigate to login screen
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}