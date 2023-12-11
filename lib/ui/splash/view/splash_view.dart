import 'package:architecture_template_v1/ui/splash/provider/splash_provider.dart';
import 'package:architecture_template_v1/ui/splash/widget/splash_loadingbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(splashProvider).setContext(context);
    ref.read(splashProvider).navigate();
    return Scaffold(
      body: SplashLoadingBar(),
    );
  }
}
