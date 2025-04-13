import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.isPassword = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.validator,
    this.keyboardType,
    required this.title,
    this.isEnabled = true,
    this.tailWidget,
    this.suffixWidget,
    this.leadingIconColor,
    this.maxLength,
    this.onChanged,
    this.focusNode,
    this.onTap,
    this.onClose,
    this.showLabel = true,
  });
  final TextEditingController textEditingController;
  final String hintText, title;
  final bool isPassword, isExpanded, isEnabled, showLabel;
  final Widget? tailWidget, suffixWidget;
  final String? leadingIcon;
  final Color? leadingIconColor;
  final int? maxLength;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onClose;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        widget.title.isNotEmpty && !widget.showLabel
            ? Text(
                widget.title,
                style: Styles.textStyle12Regular.copyWith(
                  color: Color(0xff6E6A7C),
                ),
              )
            : SizedBox(),
        TextFormField(
          keyboardType: widget.keyboardType ?? TextInputType.text,
          focusNode: widget.focusNode,
          inputFormatters:
              widget.keyboardType == TextInputType.number ||
                      widget.keyboardType == TextInputType.phone
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : [],
          style: Styles.textStyle14Regular,
          maxLength: widget.maxLength,
          enabled: widget.isEnabled,
          controller: widget.textEditingController,
          validator: widget.validator,
          obscureText: widget.isPassword ? !isVisible : false,
          cursorRadius: const Radius.circular(500),
          maxLines: widget.isExpanded ? null : 1,
          decoration: InputDecoration(
            constraints: BoxConstraints(
              maxHeight: 331,
            ),
            fillColor: AppColors.backgroundColor,
            filled: true,
            errorStyle: Styles.textStyle9Regular.copyWith(
              color: AppColors.errorColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: widget.textEditingController.text.isNotEmpty
                    ? AppColors.focusColor
                    : AppColors.borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: const BorderSide(
                color: AppColors.focusColor,
                width: 1.5,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: Styles.textStyle14Regular.copyWith(
              color: AppColors.hintTextColor,
            ),
            errorMaxLines: 4,
            labelText:
                _isFocused && widget.showLabel ? widget.title : null,
            labelStyle: Styles.textStyle14Regular,
            prefixIcon: widget.tailWidget ??
                (widget.leadingIcon == null
                    ? null
                    : SvgPicture.asset(
                        widget.leadingIcon!,
                        height: 24,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                          widget.leadingIconColor ??
                              AppColors.iconColor,
                          BlendMode.srcIn,
                        ),
                      )),
            suffixIcon: widget.isPassword ||
                    widget.suffixWidget != null
                ? widget.isPassword
                    ? IconButton(
                        onPressed: () => setState(() {
                          isVisible = !isVisible;
                        }),
                        icon: SvgPicture.asset(
                          isVisible
                              ? AppIcons.coreCommonAssetsIconsOpenEye
                              : AppIcons
                                  .coreCommonAssetsIconsClosedEye,
                          height: 25,
                          fit: BoxFit.scaleDown,
                          colorFilter: widget.isEnabled
                              ? const ColorFilter.mode(
                                  AppColors.borderColor,
                                  BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  AppColors.hintTextColor,
                                  BlendMode.srcIn),
                        ),
                      )
                    : widget.suffixWidget
                : null,
          ),
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (value.isNotEmpty) {
              setState(() {
                _isFocused = true;
              });
            } else {
              setState(() {
                _isFocused = false;
              });
            }
          },
          onTap: widget.onTap,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
