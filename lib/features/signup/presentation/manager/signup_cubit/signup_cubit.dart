import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/signup/data/models/signup_model.dart';
import 'package:todo/features/signup/data/repos/signup_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._signupRepo) : super(SignupInitial());

  final SignupRepo _signupRepo;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  String? countryCode = '+20', experienceLevel;
  final List<bool> passwordConditions = [
    false,
    false,
    false,
    false,
    false,
  ];
  bool isSubmitted = false;

  Future<void> register() async {
    emit(SignupLoading());
    var result = await _signupRepo.registerNewUser(
      SignupModel(
        displayName: nameController.text,
        phone: "$countryCode${phoneController.text}",
        password: passwordController.text,
        experienceYears: int.parse(yearsOfExperienceController.text),
        address: addressController.text,
        level: experienceLevel,
      ),
    );
    result.fold(
      (failure) => !isClosed
          ? emit(SignupFailure(errorMessage: failure.errorMessage))
          : null,
      (done) => !isClosed ? emit(SignupSuccess()) : null,
    );
  }

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
