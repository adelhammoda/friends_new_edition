

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/login/presentation/pages/login_page.dart';

import '../../features/homePage/presentation/pages/home_page.dart';

class RoutesManager{

  static Map<String,Widget Function(BuildContext context)> routes(){
    return {
      Routes.homePage:(c)=>routesWhere(Routes.login),
      Routes.login:(c)=>routesWhere(Routes.login),
    };
  }


 static Widget routesWhere(String routeName){
    switch(routeName){
      case Routes.homePage:
        return const HomePage();
      case Routes.login:
        return  LoginPage();
      default:
        //TODO:remove this container and replace it with stakeholder page
        return  Container();
    }
  }
}

class Routes{
  static const homePage = '/';
  static const login = '/login';
}