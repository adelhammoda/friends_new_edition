part of 'on_boarding_bloc.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState{}

class OnBoardingError extends OnBoardingState{
  final Failure failure;

  OnBoardingError(this.failure);
}

class OnBoardingLoaded extends OnBoardingState{
  final UserCredential userCredential;
  OnBoardingLoaded(this.userCredential);
}
