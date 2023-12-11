import 'dart:ui';

import 'package:architecture_template_v1/app/init/theme/app_colors.dart';
import 'package:architecture_template_v1/app/init/theme/app_theme.dart';
import 'package:flutter/src/material/theme_data.dart';

class DarkTheme extends AppTheme {
  @override
  Color get primaryColor => AppColors.primaryColor;

  @override
  Color get scaffoldBackgroundColor => AppColors.scaffoldBackgroundColor;

  @override
  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      );
}
