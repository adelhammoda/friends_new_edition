import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/domain/use_cases/create_account_usecase.dart';
import 'package:friends/features/login/domain/use_cases/forget_password_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_apple_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_email_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_facebook_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_google_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final CreateAccountUseCases createAccount;
  final ForgetPasswordUseCases forgetPassword;
  final LoginWithEmailAndPasswordUseCases loginWithEmailAndPassword;
  final LoginWithGoogleUseCases loginWithGoogle;
  final LoginWithFacebookUseCases loginWithFacebook;
  final LoginWithAppleUseCases loginWithApple;

  LoginBloc(
      {required this.createAccount,
      required this.forgetPassword,
      required this.loginWithEmailAndPassword,
      required this.loginWithGoogle,
      required this.loginWithFacebook,
      required this.loginWithApple})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
      if (event is LoginWithEmailAndPasswordEvent) {
        emit.call(const LoadingState(ConstantManager.loadingStatusForAuth));
        Either<Failure,UserCredential> res =await loginWithEmailAndPassword(email: event.email, password: event.password);
        res.fold((failure) =>emit(ErrorState(failure)), (userCredential) => emit(LoadedState(userCredential)));
        await Future.delayed(const Duration(seconds: 1),(){
          emit(LoginInitial());});
      }else if(event is LoginWithGoogleEvent){
        emit.call(const LoadingState(ConstantManager.loadingStatusForAuthenticationWithGoogle));
        Either<Failure,UserCredential> res =await loginWithGoogle();
        res.fold((failure) =>emit(ErrorState(failure)), (userCredential) => emit(LoadedState(userCredential)));
        await Future.delayed(const Duration(seconds: 1),(){
          emit(LoginInitial());});
      }else if (event is LoginWithFacebookEvent){
        emit.call(const LoadingState(ConstantManager.loadingStatusForAuthenticationWithFacebook));
        Either<Failure,UserCredential> res =await loginWithFacebook();
        res.fold((failure) {
          emit(ErrorState(failure));
        }, (userCredential) => emit(LoadedState(userCredential)));
       await Future.delayed(const Duration(seconds: 1),(){
          emit(LoginInitial());
        });
      }else if(event is LoginWithAppleEvent){
        emit.call(const LoadingState(ConstantManager.loadingStatusForAuthenticationWithApple));
        Either<Failure,UserCredential> res =await loginWithApple();
        res.fold((failure) =>emit(ErrorState(failure)), (userCredential) => emit(LoadedState(userCredential)));
        await Future.delayed(const Duration(seconds: 1),(){
          emit(LoginInitial());});
      }
      else if(event is ForgetPasswordNavigatorEvent){
        emit(LoginInitial());
        forgetPassword(event.context);
      }
      else if(event is CreateAccountNavigatorEvent){
        emit(LoginInitial());
        createAccount(context:event.context,email: event.email,password: event.password);
      }
    });
  }
}
