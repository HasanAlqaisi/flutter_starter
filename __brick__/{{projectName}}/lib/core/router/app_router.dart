import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:{{projectName}}/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, initial: true),
  ];
}

final routerProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
