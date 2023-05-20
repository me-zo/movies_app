import 'package:movies_app/core/fixtures/theme_codes.dart';
import 'package:movies_app/models/faqs_list_model.dart';
import 'package:movies_app/presentation/base_view_model.dart';

import '../../core/fixtures/language_codes.dart';
import '../../models/settings_model.dart';
import 'actions_repo.dart';

class ActionsViewModel extends BaseViewModel {
  final ActionsRepo _actionsRepo = ActionsRepo();

  SettingsModel settingsModel = SettingsModel.empty();
  FaqsListModel faqsList = FaqsListModel.empty();
  String selectedLanguage = LanguageCodes.english;
  String selectedTheme = ThemeCodes.dark;
  late List<bool> faqsIsExpanded;

  void prepareSettings() {
    setBusy();
    var result = _actionsRepo.loadSettings();
    result.fold(
      (l) {},
      (r) {
        settingsModel = r;
        selectedLanguage = r.local;
        selectedTheme = r.theme;
      },
    );
    setIdle();
  }

  void prepareFaqs() {
    setBusy();
    var result = _actionsRepo.loadFaqs();
    result.fold(
      (l) {},
      (r) {
        faqsList = r;
        faqsIsExpanded = List.generate(r.questions.length, (index) => false);
      },
    );
    setIdle();
  }

  void changeTheme(String theme) {
    _actionsRepo.changeTheme(theme: theme);
    notifyListeners();
  }

  void changeLanguage(String language) {
    _actionsRepo.changeLanguage(language: language);
    notifyListeners();
  }
}
