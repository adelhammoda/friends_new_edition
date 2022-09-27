

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/features/forget_password/presentation/pages/forget_password_page.dart';
import 'package:friends/features/homePage/presentation/manager/homepage_bloc.dart';
import 'package:friends/features/homePage/presentation/pages/offer_details_page.dart';
import 'package:friends/features/login/presentation/pages/login_page.dart';
import 'package:friends/features/homePage/presentation/pages/home_page.dart';
import 'package:friends/features/register/presentation/pages/register_page.dart';
import 'package:friends/injection_container.dart' as dl;

class RoutesManager{

  static Map<String,Widget Function(BuildContext context)> routes(){
    return {
      Routes.homePage:(c)=>routesWhere(Routes.homePage),
      Routes.login:(c)=>routesWhere(Routes.login),
      Routes.offerDetails:(c)=>routesWhere(Routes.offerDetails),
      Routes.forgetPassword:(c)=>routesWhere(Routes.forgetPassword),
      Routes.register:(c)=>routesWhere(Routes.register),
    };
  }


 static Widget routesWhere(String routeName){
    switch(routeName){
      case Routes.homePage:
        return  BlocProvider<HomepageBloc>(
            create: (c) => dl.sl(),
            child:const HomePage());
      case Routes.login:
        return  const LoginPage();
      case Routes.register:
        return  RegisterPage();
      case Routes.forgetPassword:
        return const ForgetPasswordPage();
      case Routes.offerDetails:
        return const OfferDetailsPage();
      default:
        //TODO:remove this container and replace it with stakeholder page
        return  Container();
    }
  }
}

class Routes{
  static const homePage = '/';
  static const login = '/login';
  static const register = '/register';
  static const forgetPassword = '/forget_password';
  static const offerDetails = '/offer_details';
}