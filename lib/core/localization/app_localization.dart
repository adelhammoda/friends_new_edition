


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';






class AppLocal {

  final Locale locale;

  AppLocal(this.locale);

  static List<String> languages() => ['en', 'ar'];
  String get languageCode => locale.toString();
  int get languageIndex => languages().contains(languageCode) ? languages().indexOf(languageCode) : 0;

  static AppLocal of(BuildContext context)=>
     Localizations.of<AppLocal>(context, AppLocal)!;

  static const  LocalizationsDelegate<AppLocal> delegate= _AppLocalizationDelegate();


  String translate(String key,{String nullCase = ""}){
    return translateMap[key]??{}[languageCode]??nullCase;
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocal>{

  const  _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale)=> ['en','ar'].contains(locale.languageCode);


  @override
  Future<AppLocal> load(Locale locale) async{
    AppLocal appLocalizations = AppLocal(locale);
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocal> old) =>this!=old;


}


  Locale createLocale(String language) => language.contains('_')
      ? Locale.fromSubtags(
    languageCode: language.split('_').first,
    scriptCode: language.split('_').last,
  )
      : Locale(language);

///global map for translate
Map<String,Map<String,String>> translateMap= {
  "friends":{
    'en':'friends',
    'ar':'الأصدقاء'
  }
};

///