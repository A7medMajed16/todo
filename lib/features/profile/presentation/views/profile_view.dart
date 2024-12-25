import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_app_bar.dart';
import 'package:todo/features/profile/presentation/views/widgets/profile/profile_view_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.profile,
        context: context,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: ScreenDimensions.width > 500 ? 500 : double.infinity,
            child: ProfileViewBody(),
          ),
        ),
      ),
    );
  }
}
