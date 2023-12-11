import 'package:architecture_template_v1/app/route/route_name.dart';
import 'package:architecture_template_v1/ui/home/view/home_view.dart';
import 'package:architecture_template_v1/ui/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grock/grock.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouter = GoRouter(
    navigatorKey: Grock.navigationKey,
    routes: [
      GoRoute(
          name: RouteName.splash.name,
          path: RouteName.splash.path,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: SplashView(),
            );
          }),
      GoRoute(
        name: RouteName.home.name,
        path: RouteName.home.path,
        pageBuilder: (context, state) {
          final arguments = state.extra;
          final renk = (arguments is Map) ? arguments['color'] : null;
          final sayi = (arguments is Map) ? arguments['number'] : null;
          return MaterialPage(
            key: state.pageKey,
            child: HomeView(
              color: renk,
              number: sayi,
            ),
          );
        },
      ),
    ],
  );
  return goRouter;
});
