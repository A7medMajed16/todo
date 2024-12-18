import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';

class CustomDropButton extends StatelessWidget {
  const CustomDropButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.title,
    this.hint,
    this.validator,
  });
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic value;
  final void Function(dynamic)? onChanged;
  final String? title, hint;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      value: value,
      menuMaxHeight: 200,
      onChanged: onChanged,
      isExpanded: true,
      autofocus: false,
      validator: validator,
      hint: Text(
        hint!,
        style: Styles.textStyle14Regular.copyWith(
          color: AppColors.hintTextColor,
        ),
      ),
      icon: SvgPicture.asset(AppIcons.coreCommonAssetsIconsDownArrow),
      decoration: InputDecoration(
        fillColor: AppColors.backgroundColor,
        errorStyle: Styles.textStyle9Regular.copyWith(
          color: AppColors.errorColor,
        ),
        errorMaxLines: 4,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: value != null ? AppColors.focusColor : AppColors.borderColor,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: value != null ? AppColors.focusColor : AppColors.borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.focusColor,
            width: 1.5,
          ),
        ),
      ),
      elevation: 9,
      borderRadius: BorderRadius.circular(8),
      dropdownColor: const Color(0xffF7F9FA),
    );
  }
}
