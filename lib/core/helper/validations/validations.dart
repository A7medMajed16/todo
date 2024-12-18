import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validations {
  static late AppLocalizations _localizations;
  static void init(BuildContext context) {
    _localizations = AppLocalizations.of(context)!;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return _localizations.email_empty;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return _localizations.invalid_email;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return _localizations.password_empty;
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return _localizations.password_error_lowercase;
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return _localizations.password_error_uppercase;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return _localizations.password_error_number;
    }

    if (!value
        .contains(RegExp(r'[!@#\$%\^&\*\(\)_\-\+=\[\]\{\};:\,<>\./\\|~`]'))) {
      return _localizations.password_error_special;
    }

    if (value.length < 6 || value.length > 30) {
      return _localizations.password_error_length;
    }

    return null;
  }

  static String? validatePasswordVerification(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return _localizations.password_verify_empty;
    } else if (value != password) {
      return _localizations.password_verify_error;
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return _localizations.phone_number_empty;
    } else if (value.length < 8) {
      return _localizations.phone_invalid_number;
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return _localizations.name_empty;
    } else {
      return null;
    }
  }

  static String? validateYearsOfExperience(String? value) {
    if (value == null || value.isEmpty) {
      return _localizations.years_of_experience_empty;
    } else {
      return null;
    }
  }

  static String? validateExperienceLevel(String? value) {
    if (value == null || value.isEmpty) {
      return _localizations.experience_level_empty;
    } else {
      return null;
    }
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return _localizations.address_empty;
    } else {
      return null;
    }
  }
}
