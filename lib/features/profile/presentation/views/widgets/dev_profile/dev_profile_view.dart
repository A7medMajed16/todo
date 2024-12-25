import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_app_bar.dart';
import 'package:todo/features/profile/presentation/views/widgets/dev_profile/dev_profile_view_body.dart';

class DevProfileView extends StatelessWidget {
  const DevProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Developer Info",
        context: context,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: ScreenDimensions.width > 500 ? 500 : double.infinity,
            child: DevProfileViewBody(),
          ),
        ),
      ),
    );
  }
}
