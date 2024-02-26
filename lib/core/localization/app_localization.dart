


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {

  final Locale locale;
  late Map<String , String> _localizationMap;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context)=>
     Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const  LocalizationsDelegate<AppLocalizations> delegate= _AppLocalizationDelegate();

  Future<void> load()async{
    String jsonString =
        await rootBundle.loadString("assets/lang/${locale.languageCode}.json");
    Map convertedJson = jsonDecode(jsonString);
    _localizationMap = convertedJson.map((key, value) => MapEntry(key.toString(), value.toString()));
  }

  String translate(String key,{String nullCase = ""}){
    return _localizationMap[key]??nullCase;
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{

  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale)=> ['en','ar'].contains(locale.languageCode);


  @override
  Future<AppLocalizations> load(Locale locale) async{
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>this!=old;
}