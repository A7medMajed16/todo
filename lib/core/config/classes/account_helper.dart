import 'package:todo/main.dart';

class AccountHelper {
  Future<String?> getUserId() async =>
      await secureStorage!.read(key: "user_id");
  bool getUserLoginStats() =>
      sharedPreferences?.getBool("user_logged") != null &&
      sharedPreferences!.getBool("user_logged")!;
}
