import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/responsive_text_size_calculator.dart';

abstract class Styles {
  static TextStyle textStyle24Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 24),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle19Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 19),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle16Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 16),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle14Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 14),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle14Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 14),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle12Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 12),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle12Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 12),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle12Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 12),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle9Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 9),
    fontWeight: FontWeight.w400,
  );
}
