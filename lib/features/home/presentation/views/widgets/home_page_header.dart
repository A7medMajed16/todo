import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/app_images.dart';

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
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          icon: SvgPicture.asset(
            AppIcons.coreCommonAssetsIconsLogout,
            height: 26,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
