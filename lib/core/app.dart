

import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/routes/routes.dart';


class App extends StatelessWidget {

  const App._internal();

  static const App  instance =  App._internal();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ConstantManager.appTitle,
      routes: RoutesManager.routes(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          shadowColor:ColorManager.white.withOpacity(0),
          backgroundColor: ColorManager.white.withOpacity(0),
          elevation: 0,

        )
      ),
    );
  }
}
