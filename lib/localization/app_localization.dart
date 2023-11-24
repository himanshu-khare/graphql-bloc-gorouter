import 'en_us/en_us_translations.dart';
import 'package:flutter/cupertino.dart';

class AppLocalization {
  AppLocalization(this.locale);

  Locale locale;

  static final Map<String, Map<String, String>> _localizedValues = {'en': enUs};

  static List<String> languages() => _localizedValues.keys.toList();
  static String getString(String text) => _localizedValues['en']![text] ?? text;
}

extension LocalizationExtension on String {
  String get tr => AppLocalization.getString(this);
}
