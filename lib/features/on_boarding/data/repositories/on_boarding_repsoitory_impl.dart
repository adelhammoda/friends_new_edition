



import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/on_boarding/domain/repositories/on_boarding_repository.dart';

class OnBoardingRepositoryImpl extends OnBoardingRepository{
  @override
  Either<Failure, void> navigateToLogin(BuildContext context) {
    // TODO: implement navigateToLogin
    throw UnimplementedError();
  }

  @override
  Either<Failure, void> navigateToRegister(BuildContext context) {
    // TODO: implement navigateToRegister
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> tryAutoLogin() {
    // TODO: implement tryAutoLogin
    throw UnimplementedError();
  }
}