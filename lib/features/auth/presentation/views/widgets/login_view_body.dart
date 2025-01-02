import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/common/widgets/custom_phone_number_text_field.dart';
import 'package:todo/core/common/widgets/custom_snack_bar.dart';
import 'package:todo/core/common/widgets/custom_text_field.dart';
import 'package:todo/core/helper/validations/validations.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/core/theme/app_images.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/auth/presentation/manager/login_cubit/login_cubit.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final LoginCubit loginCubit = context.read<LoginCubit>();
    final GoRouter router = GoRouter.of(context);
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 24,
              children: [
                Center(
                  child: Hero(
                    tag: "auth_photo",
                    child: Image.asset(
                      AppImages.coreCommonAssetsImagesSignup,
                      width: ScreenDimensions.width,
                      height: ScreenDimensions.height * 0.5,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 24,
                    children: [
                      Text(
                        localizations.login_title,
                        style: Styles.textStyle24Bold,
                      ),
                      CustomPhoneNumberTextField(
                        controller: loginCubit.phoneController,
                        countryPhoneCodeUpdateFunction: (value) =>
                            loginCubit.changeCountryCode(value ?? "+20"),
                        validator: (value) => Validations.validatePhoneNumber(
                            value, loginCubit.countryCode),
                      ),
                      CustomTextField(
                        textEditingController: loginCubit.passwordController,
                        hintText: localizations.login_password_hint,
                        title: localizations.login_password,
                        validator: (value) =>
                            Validations.validateLoginPassword(value),
                        isPassword: true,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: CustomButton(
                          isLoading: state is LoginLoading,
                          onPressed: () =>
                              _loginFormKey.currentState!.validate()
                                  ? {
                                      loginCubit.login(),
                                    }
                                  : null,
                          title: localizations.login_button,
                        ),
                      ),
                      Center(
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: localizations.login_dont_have_account,
                            style: Styles.textStyle14Regular
                                .copyWith(color: Color(0xff7F7F7F)),
                            children: <InlineSpan>[
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                baseline: TextBaseline.alphabetic,
                                child: InkWell(
                                  onTap: () => router.push(AppRouter.kSignUp),
                                  splashColor: Colors.transparent,
                                  child: Text(
                                    localizations.login_register,
                                    style: Styles.textStyle14Bold.copyWith(
                                      color: AppColors.interactText,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.interactText,
                                      decorationThickness: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, LoginState state) {
        if (state is LoginFailure) {
          if (state.errorMessage == "يوجد خطأ في رقم الهاتف أو كلمة المرور") {
            CustomSnackBar.show(
              context: context,
              message: localizations.login_wrong_user,
              isError: true,
            );
          } else {
            log("login_view_body-LoginFailure:${state.errorMessage}");
            CustomSnackBar.show(
              context: context,
              message: localizations.login_error,
              isError: true,
            );
          }
        } else if (state is LoginSuccess) {
          CustomSnackBar.show(
            context: context,
            message: localizations.login_success,
            isDone: true,
          );
          router.go(AppRouter.kHome);
        }
      },
    );
  }
}
