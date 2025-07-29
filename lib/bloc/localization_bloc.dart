import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order3000_flutter/models/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

const languagePrefsKey = 'languagePrefs';

class LocalizationBloc extends Bloc<LocalizationEvent, AppLocalizationState> {
  LocalizationBloc() : super(const AppLocalizationState()) {
    on<ChangeLanguage>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  Future<void> onChangeLanguage(
      ChangeLanguage event, Emitter<AppLocalizationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      languagePrefsKey,
      event.selectedLanguage.value.languageCode,
    );
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  Future<void> onGetLanguage(
      GetLanguage event, Emitter<AppLocalizationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final selectedLanguageCode = prefs.getString(languagePrefsKey);
    final selectedLanguage = selectedLanguageCode != null
        ? Language.values.firstWhere(
            (item) => item.value.languageCode == selectedLanguageCode,
            orElse: () => Language.english,
          )
        : Language.english;
    emit(state.copyWith(selectedLanguage: selectedLanguage));
  }
}
