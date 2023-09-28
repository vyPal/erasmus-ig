import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get balloon => 'Balloon';

  @override
  String get background => 'Background';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get settings => 'Settings';

  @override
  String get selectBalloon => 'Select balloon';

  @override
  String get equipBalloon => 'Equip';

  @override
  String get selectBackground => 'Select background';

  @override
  String get equipBackground => 'Equip';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get hapticFeedbackOn => 'Haptic feedback on';

  @override
  String get hapticFeedbackOff => 'Haptic feedback off';

  @override
  String score(double value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }
}
