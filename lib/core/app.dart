

import 'package:flutter/material.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/manager/theme_manager.dart';


import '../features/register/presentation/pages/register_page.dart';



class App extends StatelessWidget {

  const App._internal();

  static const App  instance =  App._internal();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ConstantManager.appTitle,
      // routes: RoutesManager.routes(),
      home:  RegisterPage(),
      theme: ThemeManager.getAllThemeData(),
    );
  }
}
