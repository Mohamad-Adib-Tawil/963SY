import 'package:flutter/material.dart';

class SimpleLocalizations {
  final Locale locale;

  SimpleLocalizations(this.locale);

  static SimpleLocalizations of(BuildContext context) {
    return Localizations.of<SimpleLocalizations>(context, SimpleLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'map': 'Syria Map',
    },
    'ar': {
      'map': 'خريطة سوريا',
    },
    'fr': {
      'map': 'Carte de la Syrie',
    },
  };

  String get map => _localizedValues[locale.languageCode]!['map']!;

  static const LocalizationsDelegate<SimpleLocalizations> delegate =
      _SimpleLocalizationsDelegate();
}

class _SimpleLocalizationsDelegate
    extends LocalizationsDelegate<SimpleLocalizations> {
  const _SimpleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'fr'].contains(locale.languageCode);

  @override
  Future<SimpleLocalizations> load(Locale locale) async {
    return SimpleLocalizations(locale);
  }

  @override
  bool shouldReload(_SimpleLocalizationsDelegate old) => false;
}
