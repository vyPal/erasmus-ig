import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get balloon => 'Ballon';

  @override
  String get background => 'Hintergrund';

  @override
  String get leaderboard => 'Bestenliste';

  @override
  String get settings => 'Einstellungen';

  @override
  String get selectBalloon => 'Ballon auswählen';

  @override
  String get equipBalloon => 'Ausrüsten';

  @override
  String get selectBackground => 'Hintergrund auswählen';

  @override
  String get equipBackground => 'Ausrüsten';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get hapticFeedbackOn => 'Haptisches Feedback an';

  @override
  String get hapticFeedbackOff => 'Haptisches Feedback aus';

  @override
  String score(double value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }
}
