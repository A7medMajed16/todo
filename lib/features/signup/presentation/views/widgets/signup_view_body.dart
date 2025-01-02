import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/common/widgets/custom_drop_button.dart';
import 'package:todo/core/common/widgets/custom_phone_number_text_field.dart';
import 'package:todo/core/common/widgets/custom_snack_bar.dart';
import 'package:todo/core/common/widgets/custom_text_field.dart';
import 'package:todo/core/helper/validations/validations.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/signup/data/models/experience_level_data.dart';
import 'package:todo/features/signup/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:todo/features/signup/presentation/views/widgets/password_conditions.dart';

class SignupViewBody extends StatelessWidget {
  SignupViewBody({super.key});
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final SignupCubit signupCubit = context.read<SignupCubit>();
    final GoRouter router = GoRouter.of(context);
    return Stack(
      children: [
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return Form(
                key: _signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Center(
                      child: Hero(
                        tag: "auth_photo",
                        child: Image.asset(
                          AppImages.coreCommonAssetsImagesSignup,
                          fit: BoxFit.fitWidth,
                          width: ScreenDimensions.width * 0.8,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 15,
                        children: [
                          Text(
                            localizations.sign_up_title,
                            style: Styles.textStyle24Bold,
                          ),
                          CustomTextField(
                            textEditingController: signupCubit.nameController,
                            hintText: localizations.sign_up_name_hint,
                            title: localizations.sign_up_name,
                            validator: (value) =>
                                Validations.validateName(value),
                          ),
                          CustomPhoneNumberTextField(
                            controller: signupCubit.phoneController,
                            countryPhoneCodeUpdateFunction: (value) =>
                                signupCubit.changeCountryCode(value ?? "+20"),
                            validator: (value) =>
                                Validations.validatePhoneNumber(
                                    value, signupCubit.countryCode),
                          ),
                          CustomTextField(
                            textEditingController:
                                signupCubit.yearsOfExperienceController,
                            hintText:
                                localizations.sign_up_years_of_experience_hint,
                            title: localizations.sign_up_years_of_experience,
                            validator: (value) =>
                                Validations.validateYearsOfExperience(value),
                            keyboardType: TextInputType.number,
                          ),
                          CustomDropButton(
                            items: ExperienceLevelData().experienceLevelItems,
                            value: signupCubit.experienceLevel,
                            onChanged: (value) =>
                                signupCubit.updateExperienceLevel(value),
                            validator: (value) =>
                                Validations.validateExperienceLevel(value),
                            hint: localizations.sign_up_experience_level_hint,
                            title: localizations.sign_up_experience_level,
                          ),
                          CustomTextField(
                            textEditingController:
                                signupCubit.addressController,
                            hintText: localizations.sign_up_address_hint,
                            title: localizations.sign_up_address,
                            validator: (value) =>
                                Validations.validateAddress(value),
                          ),
                          CustomTextField(
                            textEditingController:
                                signupCubit.passwordController,
                            hintText: localizations.sign_up_password_hint,
                            focusNode: signupCubit.passwordFocusNode,
                            title: localizations.sign_up_password,
                            isPassword: true,
                            onChanged: (value) =>
                                signupCubit.updatePasswordConditions(value),
                            validator: (value) =>
                                Validations.validatePassword(value),
                            onTap: () => signupCubit.updatePasswordConditions(
                                signupCubit.passwordController.text),
                            onClose: () => signupCubit.updatePasswordConditions(
                                signupCubit.passwordController.text),
                          ),
                          signupCubit.passwordFocusNode.hasFocus ||
                                  signupCubit.isSubmitted
                              ? const PasswordConditions()
                              : const SizedBox(),
                          signupCubit.passwordFocusNode.hasFocus ||
                                  signupCubit.isSubmitted
                              ? const SizedBox(height: 20)
                              : const SizedBox(),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: BlocConsumer<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return CustomButton(
                                  isLoading: state is SignupLoading,
                                  title: localizations.sign_up_title,
                                  onPressed: () => _signupFormKey.currentState!
                                          .validate()
                                      ? {
                                          signupCubit.register(),
                                        }
                                      : {
                                          signupCubit.updateIsSubmittedState(),
                                        },
                                );
                              },
                              listener:
                                  (BuildContext context, SignupState state) {
                                if (state is SignupSuccess) {
                                  router.pop();
                                  CustomSnackBar.show(
                                    context: context,
                                    message: localizations.signup_success,
                                    isDone: true,
                                  );
                                } else if (state is SignupFailure) {
                                  log("error message:${state.errorMessage}");
                                  if (state.errorMessage ==
                                      "رقم الهاتف مستخدم بالفعل") {
                                    CustomSnackBar.show(
                                      context: context,
                                      message: localizations.signup_user_exists,
                                      isError: true,
                                    );
                                  } else {
                                    CustomSnackBar.show(
                                      context: context,
                                      message: localizations.signup_failed,
                                      isError: true,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          Center(
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: localizations.sign_up_have_account,
                                style: Styles.textStyle14Regular
                                    .copyWith(color: Color(0xff7F7F7F)),
                                children: <InlineSpan>[
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    baseline: TextBaseline.alphabetic,
                                    child: InkWell(
                                      onTap: () => router.pop(),
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        localizations.login_button,
                                        style: Styles.textStyle14Bold.copyWith(
                                          color: AppColors.interactText,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.interactText,
                                          decorationThickness: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.5),
            child: InkWell(
              onTap: () => router.pop(),
              splashColor: AppColors.splashColor,
              borderRadius: BorderRadius.circular(ScreenDimensions.width),
              hoverColor: Colors.transparent,
              child: Transform.flip(
                flipX: true,
                child: SvgPicture.asset(
                  AppIcons.coreCommonAssetsIconsArrowLeft,
                  height: 30,
                  width: 30,
                  colorFilter:
                      ColorFilter.mode(AppColors.iconColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
