import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/signup/presentation/manager/signup_cubit/signup_cubit.dart';

class PasswordConditions extends StatelessWidget {
  const PasswordConditions({super.key});

  @override
  Widget build(BuildContext context) {
    SignupCubit signupCubit = context.read<SignupCubit>();
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      signupCubit.passwordConditions[index]
                          ? AppIcons.coreCommonAssetsIconsCheckCircle2
                          : AppIcons.coreCommonAssetsIconsCloseCircle,
                      height: 15,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      getConditionTitle(index, context),
                      style: !signupCubit.passwordConditions[index] &&
                              signupCubit.isSubmitted
                          ? Styles.textStyle12Bold
                              .copyWith(color: AppColors.errorColor)
                          : Styles.textStyle12Regular,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      signupCubit.passwordConditions[index + 3]
                          ? AppIcons.coreCommonAssetsIconsCheckCircle2
                          : AppIcons.coreCommonAssetsIconsCloseCircle,
                      height: 15,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      getConditionTitle(index + 3, context),
                      style: !signupCubit.passwordConditions[index + 3] &&
                              signupCubit.isSubmitted
                          ? Styles.textStyle12Bold
                              .copyWith(color: AppColors.errorColor)
                          : Styles.textStyle12Regular,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String getConditionTitle(int index, BuildContext context) {
    AppLocalizations S = AppLocalizations.of(context)!;
    List<String> passwordConditions = [
      S.set_password_1_condition,
      S.set_password_2_condition,
      S.set_password_3_condition,
      S.set_password_4_condition,
      S.set_password_5_condition,
    ];
    return passwordConditions[index];
  }
}
