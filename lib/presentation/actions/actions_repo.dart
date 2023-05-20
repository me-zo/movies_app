import 'package:dartz/dartz.dart';

import '../../../core/dependency_registrar/dependencies.dart';
import '../../../core/errors/errors.dart';
import '../settings_view_model.dart';
import '../../models/faqs_list_model.dart';
import '../../models/settings_model.dart';

class ActionsRepo {
  final SettingsNotifier _settingsNotifier = getIt();

  Either<Failure, SettingsModel> loadSettings() => Right(
        SettingsModel(
          local: _settingsNotifier.getLocale.languageCode,
          theme: _settingsNotifier.getThemeName,
        ),
      );

  Either<Failure, void> changeLanguage({required String language}) {
    _settingsNotifier.setLocale(language);
    return const Right(null);
  }

  Either<Failure, void> changeTheme({required String theme}) {
    _settingsNotifier.setTheme(theme);
    return const Right(null);
  }

  Either<Failure, FaqsListModel> loadFaqs() {
    return Right(FaqsListModel(questions: [
      FaqsQuestionModel(
          title: "presentation.actions.faqsQuestion1Title",
          answer: "presentation.actions.faqsQuestion1Body"),
      FaqsQuestionModel(
          title: "presentation.actions.faqsQuestion2Title",
          answer: "presentation.actions.faqsQuestion2Body"),
    ]));
  }
}
