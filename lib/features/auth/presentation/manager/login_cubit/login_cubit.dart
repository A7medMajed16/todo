import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:todo/features/auth/data/repos/login_repo.dart';
import 'package:todo/main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepo) : super(LoginInitial());

  final LoginRepo _loginRepo;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? countryCode = '+20';
  void changeCountryCode(String code) {
    countryCode = code;
  }

  void login() async {
    emit(LoginLoading());
    var result = await _loginRepo.emailAndPasswordLogin(
        phone: "$countryCode${phoneController.text}",
        password: passwordController.text);
    result.fold(
      (failure) => !isClosed ? emit(LoginFailure(failure.errorMessage)) : null,
      (done) async {
        sharedPreferences!.setString("user_logged", "true");
        !isClosed ? emit(LoginSuccess()) : null;
      },
    );
  }

  void logout() async {
    emit(LogoutLoading());
    var result = await _loginRepo.logout();
    result.fold(
      (failure) => !isClosed ? emit(LogoutFailure(failure.errorMessage)) : null,
      (done) async {
        sharedPreferences!.remove("user_logged");
        await DefaultCacheManager().emptyCache();
        emit(LogoutSuccess());
        !isClosed ? emit(LogoutSuccess()) : null;
      },
    );
  }
}
