import 'package:architecture_template_v1/app/base/providers/providers_logger.dart';
import 'package:architecture_template_v1/app/init/lang/locale_keys.g.dart';
import 'package:architecture_template_v1/app/init/theme/app_theme.dart';
import 'package:architecture_template_v1/app/init/theme/dark_theme.dart';
import 'package:architecture_template_v1/app/init/theme/light_theme.dart';
import 'package:architecture_template_v1/app/route/app_route.dart';
import 'package:architecture_template_v1/app/widgets/easy_loading/easy_loading_manager.dart';
import 'package:architecture_template_v1/app/database/shared_preferences/shared_pref_manager.dart';
import 'package:architecture_template_v1/app/init/lang/language_manager.dart';
import 'package:architecture_template_v1/app/utility/constant/app_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

Future<void> main() async {
  await _init();
  runApp(ProviderScope(
    observers: [ProvidersLogger()],
    child: EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstant.langAssetPath,
      startLocale: LanguageManager.instance.defaultLocale,
      fallbackLocale: LanguageManager.instance.defaultLocale,
      child: const MyApp(),
    ),
  ));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();
    //await LanguageManager.instance.getLocale();

  await SharedPrefManager.initPrefs();
  // await NetworkService.instance.init(
  //   baseUrl: NetworkConstant.baseUrl,
  //   setAuthorizationToken: () async {
  //     final tokenValue = await getToken();
  //     final mapData = {"Authorization": "Bearer $tokenValue"};
  //     return mapData;
  //   },
  // );
  EasyLoadingManager.instance.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final goRouter = ref.watch(goRouterProvider);
        final lightTheme = LightTheme();
        final darkTheme = DarkTheme();
        context.locale.logger;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: Grock.scaffoldMessengerKey,
          onGenerateTitle: (context) => LocaleKeys.appName.tr(),
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          themeMode: AppTheme.themeMode,
          theme: lightTheme.themeData,
          darkTheme: darkTheme.themeData,
        );
      },
    );
  }
}
