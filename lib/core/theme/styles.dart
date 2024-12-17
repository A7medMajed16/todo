import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/responsive_text_size_calculator.dart';

abstract class Styles {
  static TextStyle textStyle8Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 8),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle10Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 10),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle11Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 11),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle11SemiBold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 11),
    fontWeight: FontWeight.w600,
  );
  static TextStyle textStyle11Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 11),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle12Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 12),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle12Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 12),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle12SemiBold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 12),
    fontWeight: FontWeight.w600,
  );
  static TextStyle textStyle13Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 13),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle14Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 14),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle14Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 14),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle14Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 14),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle15Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 15),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle16Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 16),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle16Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 16),
    fontWeight: FontWeight.w700,
  );
  static TextStyle textStyle16Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 16),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle15Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 15),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle20Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 20),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle21Regular = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 21),
    fontWeight: FontWeight.w400,
  );
  static TextStyle textStyle24Medium = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 24),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle24Bold = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 24),
    fontWeight: FontWeight.w600,
  );
  static TextStyle textStyle24Black = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: getResponsiveFontSize(baseFontSize: 24),
    fontWeight: FontWeight.w900,
  );
  static BoxShadow dropShadow = BoxShadow(
    color: AppColors.shadowColor,
    spreadRadius: 0,
    blurRadius: 8,
    offset: const Offset(0, 0),
  );
}
