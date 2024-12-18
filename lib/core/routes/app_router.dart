import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/config/classes/account_helper.dart';
import 'package:todo/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:todo/features/auth/presentation/views/login_view.dart';
import 'package:todo/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:todo/features/signup/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:todo/features/signup/presentation/views/signup_view.dart';
import 'package:todo/main.dart';

abstract class AppRouter {
  static const String kHome = '/';
  static const String kOnboarding = '/onboarding';
  static const String kLogin = '/login';
  static const String kSignUp = '/signup';

  static final router = GoRouter(
    observers: [GoRouteObserver()],
    initialLocation: sharedPreferences!.getBool("is_first_open") == null ||
            sharedPreferences!.getBool("is_first_open")!
        ? kOnboarding
        : AccountHelper().getUserLoginStats()
            ? kHome
            : kLogin,
    routes: [
      GoRoute(
        path: kOnboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: kLogin,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kSignUp,
        builder: (context, state) => BlocProvider(
          create: (context) => SignupCubit(),
          child: const SignupView(),
        ),
      )
    ],
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
