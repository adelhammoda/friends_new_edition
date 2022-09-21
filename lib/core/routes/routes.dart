import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/forget_password/presentation/pages/forget_password_page.dart';
import 'package:friends/features/login/presentation/pages/login_page.dart';
import 'package:friends/features/on_boarding/presentation/pages/onboarding_page.dart';

import '../../features/homePage/presentation/pages/home_page.dart';
import '../../features/register/presentation/pages/register_page.dart';

class RoutesManager {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      Routes.homePage: (c) => routesWhere(Routes.onBoarding),
      Routes.login: (c) => routesWhere(Routes.login),
      Routes.register:(c)=>routesWhere(Routes.register),
      Routes.onBoarding:(c)=>routesWhere(Routes.onBoarding),
    };
  }

  static Widget routesWhere(String routeName) {
    switch (routeName) {
      case Routes.homePage:
        return const HomePage();
      case Routes.login:
        return const LoginPage();
      case Routes.register:
        return RegisterPage();
      case Routes.forgetPassword:
        return const ForgetPasswordPage();
      case Routes.onBoarding:
        return const OnBoardingPage();
      default:
        //TODO:remove this container and replace it with stakeholder page
        return Container();
    }
  }
}

class Routes {
  static const homePage = '/';
  static const login = '/login';
  static const register = '/register';
  static const forgetPassword = '/forgetPassword';
  static const onBoarding = "/onBoarding";
}
