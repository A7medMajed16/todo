import 'package:todo/main.dart';

class LocalizationHelper {
  static bool isAppArabic() => sharedPreferences?.getString('local') == "ar";
}
