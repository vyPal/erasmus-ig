import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get balloon => 'Ballon';

  @override
  String get background => 'Image de fond';

  @override
  String get leaderboard => 'Classement';

  @override
  String get settings => 'Paramètres';

  @override
  String get selectBalloon => 'Sélectionner un ballon';

  @override
  String get equipBalloon => 'Équiper';

  @override
  String get selectBackground => 'Sélectionner l\'arrière-plan';

  @override
  String get equipBackground => 'Équiper';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get hapticFeedbackOn => 'Activer la rétroaction haptique';

  @override
  String get hapticFeedbackOff => 'Désactiver la rétroaction haptique';

  @override
  String score(double value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }
}
