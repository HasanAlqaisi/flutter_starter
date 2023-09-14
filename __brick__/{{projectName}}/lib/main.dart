import 'package:{{projectName}}/core/provider_logger.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:{{projectName}}/core/constants/themes/app_theme.dart';
import 'package:{{projectName}}/core/router/app_router.dart';

// Set true if you wanna check the design on various devices
const devicePreviewMode = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure the screen size so we can have responsive view
  await ScreenUtil.ensureScreenSize();

  // Set allowed orientations
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(ProviderScope(
    observers: [ProviderLogger()],
    child: DevicePreview(
      enabled: devicePreviewMode,
      builder: (context) => const Application(),
    ),
  ));
}

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      fontSizeResolver: (fontSize, instance) =>
          instance.orientation == Orientation.portrait
              ? FontSizeResolvers.height(fontSize, instance)
              : FontSizeResolvers.diagonal(fontSize, instance),
      ensureScreenSize: true,
      rebuildFactor: devicePreviewMode
          ? RebuildFactors.change
          : RebuildFactors.orientation,
      builder: (context, child) => MaterialApp.router(
        // ignore: deprecated_member_use
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        // locale: const Locale("ar"),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [Locale('ar')],
        debugShowCheckedModeBanner: false,
        routerConfig: ref.watch(routerProvider).config(),
        theme: AppTheme.light,
        builder: (context, child) {
          final child2 = Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
          return DevicePreview.appBuilder(context, child2);
        },
      ),
    );
  }
}
