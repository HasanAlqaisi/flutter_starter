import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{projectName}}/core/constants/themes/app_theme.dart';
import 'package:{{projectName}}/core/provider_logger.dart';
import 'package:{{projectName}}/core/router/app_router.dart';
import 'package:{{projectName}}/generated/i18n/strings.g.dart';
import 'package:{{projectName}}/main_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set allowed orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Enable this to disable fonts to be loaded at runtime (http)
  // and instead use the fonts in the assets/fonts folder
  // GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: TranslationProvider(child: const Application()),
    ),
  );
}

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initAsync = ref.watch(initEntryPointProvider);

    Widget tempMaterialApp(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );

    return initAsync.when(
      data: (_) => MaterialApp.router(
        locale: const Locale('ar'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar'), Locale('en')],
        debugShowCheckedModeBanner: false,
        routerConfig: ref.watch(routerProvider).config(),
        theme: AppTheme.light,
      ),

      error: (e, s) => tempMaterialApp(
        Center(
          child: TextButton(
            onPressed: () => ref.invalidate(initEntryPointProvider),
            child: Text(
              'Failed to init, click to retry',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      loading: () => tempMaterialApp(
        Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
