import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get balloon => 'Balónek';

  @override
  String get background => 'Pozadí';

  @override
  String get leaderboard => 'Žebříček';

  @override
  String get settings => 'Nastavní';

  @override
  String get selectBalloon => 'Vyber si balónek';

  @override
  String get equipBalloon => 'Zvolit';

  @override
  String get selectBackground => 'Vyber si pozadí';

  @override
  String get equipBackground => 'Zvolit';

  @override
  String get selectLanguage => 'Změna jazyku';

  @override
  String get hapticFeedbackOn => 'Vibrace zapnuty';

  @override
  String get hapticFeedbackOff => 'Vibrace vypnuty';

  @override
  String score(double value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }
}
