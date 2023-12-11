import 'dart:developer' show log;

import 'package:flutter/foundation.dart';

mixin Loggable on ChangeNotifier {
  void logDebug(String message) {
    log(message, name: 'DEBUG', level: 0);
  }

  void logError(String message) {
    log(message, name: 'ERROR', level: 1);
  }

  void logInfo(String message) {
    log(message, name: 'INFO', level: 2);
  }

  void logWarning(String message) {
    log(message, name: 'WARNING', level: 2000);
  }
}