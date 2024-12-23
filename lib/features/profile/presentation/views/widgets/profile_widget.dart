import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/styles.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.title,
    required this.content,
    this.onTap,
    this.icon,
    this.iconPath,
  });
  final String title, content;
  final void Function()? onTap;
  final IconData? icon;
  final String? iconPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.textStyle12Medium.copyWith(
                    color: Color(0xff2F2F2F).withValues(alpha: 0.40),
                  ),
                ),
                Text(
                  content,
                  style: Styles.textStyle16Bold.copyWith(
                    color: Color(0xff2F2F2F).withValues(alpha: 0.60),
                  ),
                ),
              ],
            ),
          ),
          icon != null || iconPath != null
              ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: iconPath != null
                      ? SvgPicture.asset(
                          iconPath!,
                          height: 24,
                        )
                      : Icon(
                          icon,
                          color: AppColors.primerColor,
                          size: 30,
                        ),
                  onPressed: onTap,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
