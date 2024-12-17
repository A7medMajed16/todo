import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primerColor = Color(0xff007BFF);
  static Color splashColor = const Color(0xff007BFF).withValues(alpha: 0.1);
  static const Color buttonBackgroundColor = Color(0xff007BFF);
  static const Color filledButtonTextColor = Color(0xffFFFFFF);
  static const Color secondColor = Color(0xff007BFF);
  static const Color curserColor = Color(0xff007BFF);
  static Color selectionColor = const Color(0xff007BFF).withValues(alpha: 0.1);
  static const Color mainTextColor = Color(0xFF5A5A5A);
  static const Color hintTextColor = Color(0xFFD0D0D0);
  static const Color interactText = Color(0xFF28A745);
  static const Color focusColor = Color(0xFF28A745);
  static Color shadowColor = const Color(0xff000000).withValues(alpha: 0.25);
  static const Color backgroundColor = Color(0xffFFFFFF);
  static const Color textFieldBackgroundColor = Color(0xffFFFFFF);
  static const Color borderColor = Color(0xFFB8B8B8);
  static const Color errorColor = Color(0xffF44336);
  static const Color doneColor = Color(0xff5DA400);
  static const Color iconColor = Color(0xff4B4B4B);
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      blurRadius: 8,
      offset: const Offset(0, 0),
      color: Colors.black.withValues(alpha: 0.5),
    )
  ];
}
