

import 'package:flutter/material.dart';
import 'package:friends/home_page.dart';

class App extends StatelessWidget {

  const App._internal();

  static const App  instance =  App._internal();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //TODO:take it from [StringManager] class
      title: "Friends",
      //TODO :create [RouteManager] class and initial it to this routes
      routes: {
        '/':(c)=>const HomePage()
      },
    );
  }
}
