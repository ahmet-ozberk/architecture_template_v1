import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  late final defaultLocale = trLocale;

  List<Locale> get supportedLocales => [enLocale, trLocale];

  Locale getLocale(BuildContext context) {
    switch (View.of(context).platformDispatcher.locale.languageCode) {
      case 'en':
        return enLocale;
      case 'tr':
        return trLocale;
      default:
        return defaultLocale;
    }
  }

  Future<bool> setLocale(BuildContext context, Locale locale) async {
    if (context.locale == locale) return false;
    try {
      await context.setLocale(locale);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
