import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHelper {
  Future<void> cachedLanguageCode(String langCode) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('local', langCode);
  }

  Future<String> getCachedLanguageCode() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? cachedLanguageCode = sharedPreferences.getString('local');
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      final String deviceLanguageCode =
          ui.PlatformDispatcher.instance.locale.languageCode;
      return deviceLanguageCode;
    }
  }
}
