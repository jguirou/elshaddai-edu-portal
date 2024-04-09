import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) async {
    final String name = locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);


    Intl.defaultLocale = localeName;

    return AppLocalizations();
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }


// Add more localized strings as needed
}
