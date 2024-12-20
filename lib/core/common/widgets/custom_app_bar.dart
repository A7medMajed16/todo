import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_pop_over_widget.dart';
import 'package:todo/core/localization/localization_functions.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';

AppBar customAppBar(
        {required String title,
        required BuildContext context,
        String? taskId}) =>
    AppBar(
      backgroundColor: AppColors.backgroundColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: Padding(
        padding: LocalizationHelper.isAppArabic()
            ? const EdgeInsets.only(right: 22)
            : const EdgeInsets.only(left: 22),
        child: Transform.flip(
          flipX: !LocalizationHelper.isAppArabic(),
          child: InkWell(
            splashColor: AppColors.splashColor,
            hoverColor: Colors.transparent,
            borderRadius: BorderRadius.circular(ScreenDimensions.width),
            radius: ScreenDimensions.width,
            child: SvgPicture.asset(
              AppIcons.coreCommonAssetsIconsArrowLeft,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                AppColors.iconColor,
                BlendMode.srcIn,
              ),
            ),
            onTap: () {
              context.pop();
            },
          ),
        ),
      ),
      titleSpacing: 8,
      title: InkWell(
        splashColor: AppColors.splashColor,
        hoverColor: Colors.transparent,
        borderRadius: BorderRadius.circular(ScreenDimensions.width),
        radius: ScreenDimensions.width,
        onTap: () {
          context.pop();
        },
        child: Text(
          title,
          style: Styles.textStyle16Bold,
        ),
      ),
      centerTitle: false,
      actions: taskId != null
          ? [
              CustomPopOverWidget(
                isAppBar: true,
              ),
            ]
          : null,
    );
