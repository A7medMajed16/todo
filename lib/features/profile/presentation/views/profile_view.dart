import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/custom_app_bar.dart';
import 'package:todo/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Developer Info",
        context: context,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: ProfileViewBody(),
      ),
    );
  }
}
