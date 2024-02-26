

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:friends/core/localization/app_localization.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/manager/theme_manager.dart';
import 'package:friends/core/routes/routes.dart';




class App extends StatelessWidget {

  const App._internal();

  static const App  instance =  App._internal();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales:const [
        Locale("en","US"),
        Locale("ar"),
      ],
      localeResolutionCallback: (local,supportedLocal){
        if(local==null){
          return supportedLocal.first;
        }
        for(var spLocal in supportedLocal){
          if(spLocal.countryCode==local.countryCode&&spLocal.languageCode==local.languageCode){
            return spLocal;
          }
        }
        return supportedLocal.first;
      },
      localizationsDelegates:const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: ConstantManager.appTitle,
      routes: RoutesManager.routes(),
      // home:  RegisterPage(),
      theme: ThemeManager.getAllThemeData(),
    );
  }
}
