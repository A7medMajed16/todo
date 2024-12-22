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
    this.isColored = false,
  });
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic value;
  final void Function(dynamic)? onChanged;
  final String? title, hint;
  final String? Function(dynamic)? validator;
  final bool isColored;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        title != null
            ? Text(
                title!,
                style: Styles.textStyle12Regular.copyWith(
                  color: Color(0xff6E6A7C),
                ),
              )
            : SizedBox(),
        DropdownButtonFormField(
          items: items,
          value: value,
          menuMaxHeight: 200,
          onChanged: onChanged,
          isExpanded: true,
          autofocus: false,
          validator: validator,
          hint: Text(
            hint ?? "",
            style: Styles.textStyle14Regular.copyWith(
              color: AppColors.hintTextColor,
            ),
          ),
          icon: SvgPicture.asset(
            isColored
                ? AppIcons.coreCommonAssetsIconsDownArrow2
                : AppIcons.coreCommonAssetsIconsDownArrow,
          ),
          decoration: InputDecoration(
            fillColor:
                isColored ? AppColors.secondColor : AppColors.backgroundColor,
            filled: true,
            errorStyle: Styles.textStyle9Regular.copyWith(
              color: AppColors.errorColor,
            ),
            errorMaxLines: 4,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isColored
                    ? Colors.transparent
                    : value != null
                        ? AppColors.focusColor
                        : AppColors.borderColor,
                width: isColored ? 0 : 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: value != null
                    ? AppColors.focusColor
                    : AppColors.borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.focusColor,
                width: 1.5,
              ),
            ),
          ),
          elevation: 9,
          borderRadius: BorderRadius.circular(8),
          style: isColored
              ? Styles.textStyle16Bold.copyWith(color: AppColors.primerColor)
              : Styles.textStyle14Medium,
          dropdownColor: const Color(0xffF7F9FA),
        ),
      ],
    );
  }
}
