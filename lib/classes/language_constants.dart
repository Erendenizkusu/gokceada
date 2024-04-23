import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LAGUAGE_CODE = 'laguageCode';
const String ENGLISH = 'en';
const String TURKISH = 'tr';

Future<Locale> setLocale(String languageCode) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? TURKISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode){
  switch(languageCode){
    case ENGLISH:
      return const Locale(ENGLISH, 'US');
    case TURKISH:
      return const Locale(TURKISH, 'TR');
    default:
      return const Locale(TURKISH, 'TR');
  }
}

AppLocalizations translation(BuildContext context){
  return AppLocalizations.of(context)!;
}