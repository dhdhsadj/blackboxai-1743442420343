# Biometric Time Tracker

A Flutter application for employee time tracking using biometric authentication.

## Features
- Company authentication system (login/registration)
- Fingerprint-based time clocking
- Employee management
- Time recording with automatic calculations
- Reporting and data export
- Company profile customization

## Color Scheme
- Primary: #3EB489
- Secondary: White
- Background: White

## Technical Requirements
- Flutter 3.0+
- Dart 3.0+
- Local authentication (fingerprint)
- MySQL database via XAMPP
- REST API endpoints

## Setup Instructions
1. Install Flutter SDK
2. Run `flutter pub get` to install dependencies
3. Start XAMPP server
4. Configure API endpoints in `lib/constants.dart`
5. Run `flutter run` to launch the app

## API Endpoints
- Base URL: `http://localhost:8080/api`
- Authentication: `/auth/login`, `/auth/register`
- Employees: `/employees`
- Time Logs: `/time-logs`
- Reports: `/reports`

## Screens
- Login/Registration
- Home (Time Clock)
- Employee Management
- Reports
- Company Profile