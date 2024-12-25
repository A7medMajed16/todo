import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/localization/localization_functions.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:todo/features/home/presentation/manager/home_cubit/home_cubit.dart';

class HomePageTabsBar extends StatefulWidget {
  const HomePageTabsBar({super.key});

  @override
  State<HomePageTabsBar> createState() => _HomePageTabsBarState();
}

class _HomePageTabsBarState extends State<HomePageTabsBar>
    with TickerProviderStateMixin {
  late final HomeCubit _homeCubit;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>();
    _homeCubit.initTabController(this);
    _homeCubit.tabController!.addListener(() {
      setState(() {
        _selectedIndex = _homeCubit.tabController!.index;
      });
      _homeCubit.updateFilter(_selectedIndex == 0
          ? null
          : _selectedIndex == 1
              ? "inprogress"
              : _selectedIndex == 2
                  ? "waiting"
                  : _selectedIndex == 3
                      ? "finished"
                      : null);
    });
  }

  @override
  void dispose() {
    _homeCubit.disposeTabController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return TabBar(
          controller: _homeCubit.tabController,
          splashBorderRadius: BorderRadius.circular(ScreenDimensions.width),
          dragStartBehavior: DragStartBehavior.start,
          dividerColor: Colors.transparent,
          isScrollable: true,
          indicatorPadding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenDimensions.width),
            color: AppColors.primerColor,
          ),
          padding: EdgeInsets.zero,
          labelPadding: LocalizationHelper.isAppArabic()
              ? EdgeInsets.only(left: 8)
              : EdgeInsets.only(right: 8),
          labelStyle: Styles.textStyle16Bold.copyWith(
            color: AppColors.backgroundColor,
            fontFamily: LocalizationHelper.isAppArabic() ? 'Almarai' : 'DMSans',
          ),
          unselectedLabelStyle: Styles.textStyle16Regular.copyWith(
            color: Color(0xff7C7C80),
            fontFamily: LocalizationHelper.isAppArabic() ? 'Almarai' : 'DMSans',
          ),
          tabs: List<Widget>.generate(
            4,
            (index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenDimensions.width),
                color: index == _selectedIndex
                    ? Colors.transparent
                    : Color(0xffF0ECFF),
              ),
              child: Tab(
                height: 40,
                text: getTabTitle(index, context),
              ),
            ),
          ),
        );
      },
    );
  }

  String getTabTitle(int index, BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final List<String> tabTitles = [
      appLocalizations.home_all_tasks,
      appLocalizations.home_in_progress_tasks,
      appLocalizations.home_waiting_tasks,
      appLocalizations.home_finished_tasks,
    ];
    return tabTitles[index];
  }
}
