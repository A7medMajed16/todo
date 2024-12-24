import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/api/service_locator.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/helper/validations/validations.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/features/localization/localization_cubit/localization_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

SharedPreferences? sharedPreferences;
FlutterSecureStorage? secureStorage;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  sharedPreferences = await SharedPreferences.getInstance();
  secureStorage = const FlutterSecureStorage();
  runApp(const ToDo());
}

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalizationCubit()..getSavedLanguage(),
        ),
        // BlocProvider(
        //   create: (context) => LoginCubit(),
        // ),
        // BlocProvider(
        //   create: (context) => SignupCubit(),
        // ),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationChangeLocalLang>(
        builder: (context, state) {
          ScreenDimensions.init(context);

          return Platform.isIOS
              ? CupertinoTheme(
                  data: CupertinoThemeData(
                    primaryColor: AppColors.secondColor,
                    scaffoldBackgroundColor: AppColors.backgroundColor,
                    barBackgroundColor: AppColors.backgroundColor,
                    textTheme: CupertinoTextThemeData(
                      textStyle: TextStyle(
                        fontFamily:
                            state.langCode == 'ar' ? 'Almarai' : 'DMSans',
                      ),
                    ),
                  ),
                  child: _buildMaterialApp(context, state),
                )
              : _buildMaterialApp(context, state);
        },
      ),
    );
  }

  MaterialApp _buildMaterialApp(
      BuildContext context, LocalizationChangeLocalLang state) {
    return MaterialApp.router(
      builder: (context, child) {
        Validations.init(context);
        return child!;
      },
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(state.langCode),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        splashColor: AppColors.splashColor,
        fontFamily: state.langCode == 'ar' ? 'Almarai' : 'DMSans',
        primaryColor: AppColors.primerColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.curserColor,
          selectionColor: AppColors.selectionColor,
          selectionHandleColor: AppColors.curserColor,
        ),
      ),
    );
  }
}
