import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  static Future<void> storeFingerprintId(String employeeId, String fingerprintId) async {
    await _storage.write(
      key: 'fingerprint_$fingerprintId',
      value: employeeId,
    );
  }

  static Future<String?> getEmployeeByFingerprint(String fingerprintId) async {
    return await _storage.read(key: 'fingerprint_$fingerprintId');
  }
}