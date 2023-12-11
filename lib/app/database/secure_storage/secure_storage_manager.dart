import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorageServices {
  static const storage = FlutterSecureStorage();

  static Future<void> setString(String key, String value) async =>
      await storage.write(key: key, value: value);

  static Future<String?> getString(String key) async =>
      await storage.read(key: key);

  static Future<void> deleteString(String key) async =>
      await storage.delete(key: key);
}
