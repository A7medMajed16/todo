import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/app_images.dart';
import 'package:todo/features/auth/presentation/manager/login_cubit/login_cubit.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppImages.coreCommonAssetsImagesAppLogo,
          height: 32,
        ),
        Spacer(),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: SvgPicture.asset(
            AppIcons.coreCommonAssetsIconsPerson,
            height: 26,
          ),
          onPressed: () => context.push(AppRouter.kProfile),
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              context.go(AppRouter.kLogin);
            }
          },
          child: BlocConsumer<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LogoutLoading) {
                return SizedBox(
                  width: 24,
                  height: 24,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircularProgressIndicator(
                      color: AppColors.primerColor,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                );
              } else {
                return IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  icon: SvgPicture.asset(
                    AppIcons.coreCommonAssetsIconsLogout,
                    height: 26,
                  ),
                  onPressed: () => context.read<LoginCubit>().logout(),
                );
              }
            },
            listener: (BuildContext context, LoginState state) {
              if (state is LogoutSuccess) {
                context.go(AppRouter.kLogin);
              } else if (state is LogoutFailure) {
                log("home_page_header-LogoutFailure: ${state.errorMessage}");
              }
            },
          ),
        ),
      ],
    );
  }
}
