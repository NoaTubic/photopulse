// ignore_for_file: always_use_package_imports

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:photopulse/common/domain/notifiers/localization_notifier.dart';
import 'package:photopulse/common/utils/q_logger.dart';
import 'package:photopulse/firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'common/domain/providers/base_router_provider.dart';
import 'common/presentation/base_widget.dart';
import 'common/utils/custom_provider_observer.dart';
import 'generated/l10n.dart';
import 'main/app_environment.dart';
import 'theme/theme.dart';

Future<void> mainCommon(AppEnvironment environment) async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EnvInfo.initialize(environment);
  Loggy.initLoggy(
    logPrinter: !EnvInfo.isProduction || kDebugMode
        ? StreamPrinter(const PrettyDeveloperPrinter())
        : const DisabledPrinter(),
  );
  void runAppCallback() => SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      ).then((_) => runApp(ProviderScope(
            observers: [CustomProviderObserver()],
            child: const MyApp(),
          )));
  if (environment == AppEnvironment.PROD) {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'DSN';
      },
      appRunner: runAppCallback,
    );
  } else {
    runAppCallback();
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();
    final baseRouter = ref.watch(baseRouterProvider);
    final locale = ref.watch(localizationNotifierProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: EnvInfo.appTitle,
      theme: lightTheme,
      themeMode: ThemeMode.system,
      locale: locale,
      localizationsDelegates: const [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerDelegate: baseRouter.routerDelegate,
      routeInformationParser: baseRouter.routeInformationParser,
      routeInformationProvider: baseRouter.routeInformationProvider,
      builder: (context, child) => Material(
        type: MaterialType.transparency,
        child: BaseWidget(child ?? const SizedBox()),
      ),
    );
  }
}
