import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_floating_action_button.dart';
import 'package:todo/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SizedBox(
            width: ScreenDimensions.width > 500 ? 500 : double.infinity,
            child: HomeViewBody(),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(),
    );
  }
}
