import 'package:architecture_template_v1/app/base/mixin/base_provider_mixin.dart';
import 'package:architecture_template_v1/app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final splashProvider = ChangeNotifierProvider((ref) => SplashProvider());

class SplashProvider extends ChangeNotifier with BaseProviderMixin {
  @override
  void setContext(BuildContext context) {
    super.setContext(context);
  }

  BuildContext get context => baseContext as BuildContext;

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      context.go(RouteName.home.path, extra: {
        "color": Colors.red,
        "number": 12,
      });
    });
  }
}
