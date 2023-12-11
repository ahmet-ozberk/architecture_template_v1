import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeMode get themeMode => ThemeMode.light;
  ThemeData get themeData;
  Color get primaryColor;
  Color get scaffoldBackgroundColor;
}
