import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/api/service_locator.dart';
import 'package:todo/core/config/classes/account_helper.dart';
import 'package:todo/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:todo/features/auth/presentation/views/login_view.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:todo/features/home/presentation/views/home_view.dart';
import 'package:todo/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:todo/features/profile/presentation/views/profile_view.dart';
import 'package:todo/features/signup/data/repos/signup_repo_impl.dart';
import 'package:todo/features/signup/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:todo/features/signup/presentation/views/signup_view.dart';
import 'package:todo/features/task/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:todo/features/task/presentation/views/add_new_task/add_new_task_view.dart';
import 'package:todo/features/task/presentation/views/task_details/task_details_view.dart';
import 'package:todo/main.dart';

abstract class AppRouter {
  static const String kHome = '/';
  static const String kOnboarding = '/onboarding';
  static const String kLogin = '/login';
  static const String kSignUp = '/signup';
  static const String kTaskDetails = '/task_details';
  static const String kAddNewTask = '/add_new_task';
  static const String kProfile = '/profile';

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
        path: kHome,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomeView(),
        ),
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
          create: (context) => SignupCubit(getIt.get<SignupRepoImpl>()),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: kTaskDetails,
        builder: (context, state) => TaskDetailsView(
          taskModel: state.extra as TaskModel,
        ),
      ),
      GoRoute(
        path: kAddNewTask,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AddNewTaskCubit()..initTask(state.extra as TaskModel?),
          child: AddNewTaskView(),
        ),
      ),
      GoRoute(
        path: kProfile,
        builder: (context, state) => ProfileView(),
      ),
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
