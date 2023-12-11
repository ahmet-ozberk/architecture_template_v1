import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingManager {
  static EasyLoadingManager? _instance;
  static EasyLoadingManager get instance {
    _instance ??= EasyLoadingManager._init();
    return _instance!;
  }

  EasyLoadingManager._init();

  void init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  void show({String? status}) {
    EasyLoading.show(status: status, dismissOnTap: false);
  }

  void dismiss() {
    EasyLoading.dismiss();
  }
}
