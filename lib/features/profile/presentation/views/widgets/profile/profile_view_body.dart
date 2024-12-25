import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/common/widgets/error_page.dart';
import 'package:todo/core/localization/localization_functions.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/localization/localization_cubit/localization_cubit.dart';
import 'package:todo/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:todo/features/profile/presentation/views/widgets/dev_profile/dev_phone_bottom_sheet.dart';
import 'package:todo/features/profile/presentation/views/widgets/dev_profile/dev_profile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = context.read<ProfileCubit>();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final GoRouter router = GoRouter.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.5),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileFailure) {
            log("profile_view_body-ProfileFailure:${state.message}");
            return ErrorPage(
              onPressed: () => profileCubit.getProfileData(),
            );
          } else if (state is ProfileSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 8,
                children: [
                  SizedBox(height: 16),
                  DevProfileWidget(
                    title: appLocalizations.profile_name,
                    content: state.profileModel.displayName ?? "",
                  ),
                  DevProfileWidget(
                    title: appLocalizations.profile_phone,
                    content: state.profileModel.username ?? " ",
                    icon: Icons.more_horiz_rounded,
                    onTap: () => state.profileModel.username != null
                        ? DevPhoneBottomSheet.show(
                            context, state.profileModel.username!)
                        : null,
                  ),
                  DevProfileWidget(
                    title: appLocalizations.profile_level,
                    content: state.profileModel.level ?? "",
                  ),
                  DevProfileWidget(
                    title: appLocalizations.profile_years_of_experience,
                    content: state.profileModel.experienceYears.toString(),
                  ),
                  DevProfileWidget(
                    title: appLocalizations.profile_location,
                    content: state.profileModel.address ?? "",
                    iconPath: AppIcons.coreCommonAssetsIconsLocation,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            titleStyle: Styles.textStyle12Bold
                                .copyWith(color: AppColors.backgroundColor),
                            title: appLocalizations.profile_dev_page,
                            onPressed: () => router.push(AppRouter.kDevProfile),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            isFilled: false,
                            titleStyle: Styles.textStyle12Bold.copyWith(
                                color: AppColors.primerColor,
                                fontFamily: LocalizationHelper.isAppArabic()
                                    ? 'DMSans'
                                    : 'Almarai'),
                            borderColor: AppColors.primerColor,
                            title: LocalizationHelper.isAppArabic()
                                ? appLocalizations.profile_english
                                : appLocalizations.profile_arabic,
                            onPressed: () => context
                                .read<LocalizationCubit>()
                                .changeLanguage(LocalizationHelper.isAppArabic()
                                    ? "en"
                                    : "ar"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primerColor,
                strokeCap: StrokeCap.round,
              ),
            );
          }
        },
      ),
    );
  }
}
