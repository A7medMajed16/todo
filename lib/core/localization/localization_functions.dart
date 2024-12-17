import 'package:intl/intl.dart';

/// A class that provides functions for handling localization.
class LocalizationFunctions {
  /// Checks if the current app locale is Arabic.
  ///
  /// Returns `true` if the current locale is Arabic, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final localizationFunctions = LocalizationFunctions();
  /// if (localizationFunctions.isAppArabic()) {
  ///   print('The app is currently in Arabic');
  /// } else {
  ///   print('The app is not in Arabic');
  /// }
  /// ```
  static bool isAppArabic() => Intl.getCurrentLocale() == 'ar';
}
