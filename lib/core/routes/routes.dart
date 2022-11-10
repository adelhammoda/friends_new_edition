import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/features/QRGenerator/presentation/manager/qr_generator_bloc.dart';
import 'package:friends/features/QRGenerator/presentation/pages/qr_generator_page.dart';
import 'package:friends/features/forget_password/presentation/pages/forget_password_page.dart';
import 'package:friends/features/home_page/presentation/manager/homepage_bloc.dart';
import 'package:friends/features/home_page/presentation/pages/home_page.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';
import 'package:friends/features/login/presentation/pages/login_page.dart';
import 'package:friends/features/offer/presentation/pages/offer_page.dart';
import 'package:friends/features/register/presentation/pages/register_page.dart';
import 'package:friends/features/subscription/presentation/manager/subscription_bloc.dart';
import 'package:friends/features/subscription/presentation/pages/subscription_page.dart';
import 'package:friends/injection_container.dart' as dl;
import 'package:friends/features/on_boarding/presentation/pages/onboarding_page.dart';

class RoutesManager {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      Routes.subscriptionsPackages: (c) =>
          routesWhere(Routes.subscriptionsPackages),
      Routes.homePage: (c) => routesWhere(Routes.homePage),
      Routes.login: (c) => routesWhere(Routes.login),
      Routes.offerDetails: (c) => routesWhere(Routes.offerDetails),
      Routes.forgetPassword: (c) => routesWhere(Routes.forgetPassword),
      Routes.register: (c) => routesWhere(Routes.register),
    };
  }

  static Widget routesWhere(String routeName) {
    switch (routeName) {
      case Routes.qrGenerator:
        return BlocProvider<QrGeneratorBloc>(
          create: (c) => dl.sl<QrGeneratorBloc>(),
          child:  const QrGeneratorPage(),
        );
      case Routes.subscriptionsPackages:
        return BlocProvider<SubscriptionBloc>(
          create: (c) => dl.sl<SubscriptionBloc>(),
          child: const SubscriptionPage(),
        );
      case Routes.offer:
        return BlocProvider<OfferPageBloc>(
            create: (c) => dl.sl<OfferPageBloc>(), child: const OfferPage());
      case Routes.homePage:
        return BlocProvider<HomepageBloc>(
          create: (c) => dl.sl<HomepageBloc>(),
          lazy: true,
          child: const HomePage(),
        );
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
  static const offer = '/offer';
  static const login = '/login';
  static const register = '/register';
  static const forgetPassword = '/forgetPassword';
  static const onBoarding = "/onBoarding";
  static const offerDetails = '/offer_details';
  static const subscriptionsPackages = '/subscriptions_packages';
  static const qrGenerator = '/qr_generator';
}
