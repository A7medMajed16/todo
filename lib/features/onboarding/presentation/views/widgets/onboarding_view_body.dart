import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/app_images.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/main.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.coreCommonAssetsImagesOnboarding,
              width: ScreenDimensions.width,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 47),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localizations.onboarding_header,
                        textAlign: TextAlign.center,
                        style: Styles.textStyle24Bold,
                      ),
                      SizedBox(height: 16),
                      Text(
                        localizations.onboarding_description,
                        textAlign: TextAlign.center,
                        style: Styles.textStyle14Regular
                            .copyWith(color: Color(0xFF6E6A7C)),
                      ),
                      SizedBox(height: 32.5),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: CustomButton(
                    onPressed: () {
                      sharedPreferences!.setBool("is_first_open", true);
                    },
                    title: localizations.onboarding_button,
                    tailing: SvgPicture.asset(
                      AppIcons.coreCommonAssetsIconsArrowLeft,
                      width: 24,
                      height: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
