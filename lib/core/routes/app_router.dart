import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/config/classes/account_helper.dart';
import 'package:todo/main.dart';

abstract class AppRouter {
  static const String kHome = '/';
  static const String kOnboarding = '/onboarding';
  static const String kLogin = '/login';

  static final router = GoRouter(
    observers: [GoRouteObserver()],
    initialLocation: sharedPreferences!.getBool("is_first_open") == null ||
            sharedPreferences!.getBool("is_first_open")!
        ? kOnboarding
        : AccountHelper().getUserLoginStats()
            ? kHome
            : kLogin,
    routes: [],
  );
}

String getCurrentRoute(BuildContext context) {
  final GoRouterState state = GoRouterState.of(context);
  return state.uri.toString();
}

// Alternative method using the observer
String getCurrentRouteFromObserver() {
  return GoRouteObserver.currentRoute;
}

// Extension method on BuildContext for easier access
extension GoRouterContextExtension on BuildContext {
  String get currentRoute => getCurrentRoute(this);
}

class GoRouteObserver extends NavigatorObserver {
  static String currentRoute = '/';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      currentRoute = route.settings.name!;
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name != null) {
      currentRoute = previousRoute!.settings.name!;
    }
    super.didPop(route, previousRoute);
  }
}
