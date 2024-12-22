import 'package:bloc/bloc.dart';
import 'package:todo/features/localization/cache/cache_helper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationChangeLocalLang> {
  LocalizationCubit()
      : super(const LocalizationChangeLocalLang(langCode: 'en'));

  Future<void> getSavedLanguage() async {
    final String cachedLangCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(LocalizationChangeLocalLang(langCode: cachedLangCode));
  }

  Future<void> changeLanguage(String langCode) async {
    await LanguageCacheHelper().cachedLanguageCode(langCode);

    emit(LocalizationChangeLocalLang(langCode: langCode));
  }
}
