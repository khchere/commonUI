import 'package:common_ui/common/constant/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum Language {
  korean(Locale('ko'), '$baseUiPath/flag/flag_kr.png'),
  english(Locale('en'), '$baseUiPath/flag/flag_us.png');

  final Locale locale;
  final String flagPath;

  const Language(this.locale, this.flagPath);

  static Language find(String key) {
    return Language.values.asNameMap()[key] ?? Language.english;
  }
}

// Language get currentLanguage =>
//     App.navigatorKey.currentContext!.locale.languageCode == 'ko'
//         ? Language.korean
//         : Language.english;
Language currentLanguage(BuildContext context) {
  return context.locale.languageCode == 'ko'
      ? Language.korean
      : Language.english;
}
