import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/api/api_helper.dart';
import 'package:todo/features/auth/data/repos/login_repo_impl.dart';
import 'package:todo/features/home/data/repos/home_repo_impl.dart';
import 'package:todo/features/signup/data/repos/signup_repo_impl.dart';

/// The GetIt instance for service locator
final getIt = GetIt.instance;

/// Sets up the service locator by registering all the required repositories.
void setupServiceLocator() {
  getIt.registerSingleton<SignupRepoImpl>(
    SignupRepoImpl(
      ApiHelper(
        Dio(),
      ),
    ),
  );
  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      ApiHelper(
        Dio(),
      ),
    ),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      ApiHelper(
        Dio(),
      ),
    ),
  );
}
