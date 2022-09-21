part of 'on_boarding_bloc.dart';

@immutable
abstract class OnBoardingEvent {}

class OnBoardingAutoLoginEvent extends OnBoardingEvent {

}


class OnBoardingNavigateToLogin extends OnBoardingEvent {
  final BuildContext context;

  OnBoardingNavigateToLogin(this.context);
}

class OnBoardingNavigateToRegister extends OnBoardingEvent {
  final BuildContext context;

  OnBoardingNavigateToRegister(this.context);
}
