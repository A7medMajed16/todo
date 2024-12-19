import 'package:flutter/material.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/home/presentation/views/widgets/home_page_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/features/home/presentation/views/widgets/home_page_tabs_bar.dart';
import 'package:todo/features/home/presentation/views/widgets/tasks_list_items.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageHeader(),
              SizedBox(height: 24),
              Text(
                appLocalizations.home_my_tasks,
                style: Styles.textStyle16Bold.copyWith(
                  color: AppColors.mainTextColor.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 16),
              HomePageTabsBar(),
              SizedBox(height: 16),
            ],
          ),
        ),
        Expanded(
          child: TasksListItems(),
        )
      ],
    );
  }
}
