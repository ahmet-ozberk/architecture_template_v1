import 'package:architecture_template_v1/app/database/secure_storage/secure_storage_manager.dart';
import 'package:architecture_template_v1/app/database/shared_preferences/shared_pref_manager.dart';
import 'package:architecture_template_v1/app/utility/constant/storage_keys.dart';
import 'package:architecture_template_v1/app/widgets/_dialog/error_dialog.dart';
import 'package:architecture_template_v1/app/widgets/easy_loading/easy_loading_manager.dart';
import 'package:flutter/material.dart';


mixin BaseProviderMixin on ChangeNotifier {
  final _storage = _StorageExamples();

  BuildContext? baseContext;

  void setContext(BuildContext context) {
    baseContext = context;
  }

  void debug(String message) {
    debugPrint("[DEBUG] $message [DEBUG]");
  }

  Future<String?> get getToken async => await _storage.getToken();

  Future<bool> saveToken({required String value}) async =>
      await _storage.saveToken(value: value);

  Future<bool> removeToken() async => await _storage.removeToken();

  Future<bool> saveString({required String key, required String value}) async =>
      await _storage.saveString(key: key, value: value);

  Future<String?> getString({required String key}) async =>
      await _storage.getString(key: key);

  Future<bool> deleteString({
    required String key,
  }) async =>
      await _storage.deleteString(key: key);

  void showLoading() {
    EasyLoadingManager.instance.show();
  }

  void hideLoading() {
    EasyLoadingManager.instance.dismiss();
  }

  void showErrorDialog({
    String? title,
    String? description,
    String? nextRoute,
  }) {
    ErrorDialog(
      title: title,
      description: description,
      nextRoute: nextRoute,
    ).show();
  }

  void showInfoDialog({
    String? title,
    String? description,
    String? nextRoute,
  }) {
    ErrorDialog(
      title: title,
      description: description,
      nextRoute: nextRoute,
    ).show();
  }

  void showSuccessDialog({
    String? title,
    String? description,
    String? nextRoute,
  }) {
    ErrorDialog(
      title: title,
      description: description,
      nextRoute: nextRoute,
    ).show();
  }
}

final class _StorageExamples {
  Future<String?> getToken() async {
    final key = StorageKeys.token.name;
    try {
      final value = await SecureStorageServices.getString(key);
      return value;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> saveToken({
    required String value,
  }) async {
    final key = StorageKeys.token.name;
    try {
      await SecureStorageServices.setString(key, value);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeToken() async {
    final key = StorageKeys.token.name;
    try {
      await SecureStorageServices.deleteString(key);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveString({
    required String key,
    required String value,
  }) async {
    try {
      await SharedPrefManager.setString(key, value);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> getString({
    required String key,
  }) async {
    try {
      final value = await SharedPrefManager.getString(key);
      return value;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> deleteString({
    required String key,
  }) async {
    try {
      await SharedPrefManager.clearKey(key);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
