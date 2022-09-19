import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/data/models/user_model.dart';
import 'package:friends/features/register/domain/use_cases/Register_with_email_and_password_usecase.dart';
import 'package:friends/features/register/domain/use_cases/already_have_account_navigator_usecase.dart';
import 'package:friends/features/register/domain/use_cases/register_with_apple_usecase.dart';
import 'package:friends/features/register/domain/use_cases/register_with_facebook_usecase.dart';
import 'package:friends/features/register/domain/use_cases/register_with_google_usecase.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AlreadyHaveAccountUseCase alreadyHaveAccountNavigator;
  final RegisterWithAppleUseCase registerWithAppleUseCase;
  final RegisterWithEmailAndPasswordUseCase registerWithEmailAndPasswordUseCase;
  final RegisterWithFacebookUseCase registerWithFacebookUseCase;
  final RegisterWithGoogleUseCase registerWithGoogleUseCase;

  RegisterBloc(
      {required this.alreadyHaveAccountNavigator,
      required this.registerWithAppleUseCase,
      required this.registerWithEmailAndPasswordUseCase,
      required this.registerWithFacebookUseCase,
      required this.registerWithGoogleUseCase})
      : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async{
      if (event is SignupWithGoogle) {
        emit(const LoadingState(
            ConstantManager.loadingStatusForAuthenticationWithGoogle));
        Either<Failure,UserCredential> res =await registerWithGoogleUseCase(event.context);
        res.fold((failure) =>emit(ErrorState(failure)) , (userCredential) => LoadedState(userCredential));

      await  Future.delayed(const Duration(seconds: 1),
                (){
              emit(RegisterInitial());
            });
      } else if (event is SignupWithApple) {
        emit(const LoadingState(
            ConstantManager.loadingStatusForAuthenticationWithApple));
        Either<Failure,UserCredential> res =await registerWithAppleUseCase(event.context);
        res.fold((failure) =>emit(ErrorState(failure)) , (userCredential) => LoadedState(userCredential));
        await Future.delayed(const Duration(seconds: 1),
            (){
            print("Just for test in sign up with apple");
              emit(RegisterInitial());
            });
      } else if (event is SignupWithEmailAndPassword) {
        emit(const LoadingState(
            ConstantManager.loadingStatusForAuth));
        Either<Failure,UserCredential> res =await registerWithEmailAndPasswordUseCase(event.context,
          user: event.userModel,
          password: event.password
        );
        res.fold((failure) =>emit(ErrorState(failure)) , (userCredential) => LoadedState(userCredential));
       await Future.delayed(const Duration(seconds: 1),
                (){
              emit(RegisterInitial());
            });
      } else if (event is SignupWithFacebook) {
        emit(const LoadingState(
            ConstantManager.loadingStatusForAuthenticationWithFacebook));
        Either<Failure,UserCredential> res =await registerWithFacebookUseCase(event.context);
        res.fold((failure) =>emit(ErrorState(failure)) , (userCredential) => LoadedState(userCredential));
       await Future.delayed(const Duration(seconds: 1),
                (){
              emit(RegisterInitial());
            });
      } else if (event is AlreadyHaveAccountNavigator) {
        Either<Failure,void> res = alreadyHaveAccountNavigator(event.context);
        res.fold((failure) =>emit(ErrorState(failure)) , (_) => emit(RegisterInitial()));
      }
    });
  }
}
