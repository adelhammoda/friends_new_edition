import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/on_boarding/domain/use_cases/navigate_to_login_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/use_cases/navigate_to_register_usecase.dart';
import '../../domain/use_cases/try_auto_login_usecase.dart';

part 'on_boarding_event.dart';

part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final NavigateToLoginUseCase navigateToLoginUseCase;
  final NavigateToRegisterUseCase navigateToRegisterUseCase;
  final TryAutoLoginUseCase tryAutoLoginUseCase;

  OnBoardingBloc(
      {required this.navigateToLoginUseCase,
      required this.navigateToRegisterUseCase,
      required this.tryAutoLoginUseCase})
      : super(OnBoardingInitial()) {
    on<OnBoardingEvent>((event, emit) async {
      switch (event.runtimeType) {
        case OnBoardingNavigateToLogin:
          {
            navigateToLoginUseCase(
                context: (event as OnBoardingNavigateToLogin).context);
            break;
          }
        case OnBoardingNavigateToRegister:
          {
            navigateToRegisterUseCase(
                context: (event as OnBoardingNavigateToRegister).context);
            break;
          }
        case OnBoardingAutoLoginEvent:
          {
            emit(OnBoardingLoading());
            Either<Failure, UserCredential> res = await tryAutoLoginUseCase();
            res.fold((failure) => emit(OnBoardingError(failure)),
                (userCredential) => emit(OnBoardingLoaded(userCredential)));
            break;
          }
        default:
          {
            emit(OnBoardingInitial());
            break;
          }
      }
    });
  }
}
