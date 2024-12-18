import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  String? countryCode, experienceLevel;

  final List<bool> passwordConditions = [
    false,
    false,
    false,
    false,
    false,
  ];

  bool isSubmitted = false;
  void changeCountryCode(String code) {
    countryCode = code;
  }

  void updatePasswordConditions(String value) {
    emit(SignupInitial());
    if (value.contains(RegExp(r'[a-z]'))) {
      passwordConditions[0] = true;
    } else {
      passwordConditions[0] = false;
    }

    if (value.contains(RegExp(r'[A-Z]'))) {
      passwordConditions[1] = true;
    } else {
      passwordConditions[1] = false;
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      passwordConditions[2] = true;
    } else {
      passwordConditions[2] = false;
    }
    if (value.contains(RegExp(r'[!@#\$&*~]'))) {
      passwordConditions[3] = true;
    } else {
      passwordConditions[3] = false;
    }
    if (value.length > 6 && value.length < 30) {
      passwordConditions[4] = true;
    } else {
      passwordConditions[4] = false;
    }

    emit(SignupUpdate());
  }

  void updateIsSubmittedState() {
    emit(SignupInitial());
    isSubmitted = true;
    emit(SignupUpdate());
  }

  void updateExperienceLevel(String value) {
    experienceLevel = value;
  }
}
