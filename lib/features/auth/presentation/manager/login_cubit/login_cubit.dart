import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:todo/main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? countryCode;
  void changeCountryCode(String code) {
    countryCode = code;
  }

  void logout() async {
    sharedPreferences!.remove("user_logged");
    await DefaultCacheManager().emptyCache();
    emit(LogoutSuccess());
  }
}
