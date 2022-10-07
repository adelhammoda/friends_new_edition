import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';

abstract class OnBoardingRepository {
  ///Call this method while page loading.
  ///Will do auto login and try to fetch user from
  ///local storage then will send it to firebase
  ///to make sure that user still have the account
  Future<Either<Failure, UserCredential>> tryAutoLogin();

  ///navigate to login page .
  Either<Failure,void> navigateToLogin(BuildContext context);

  ///navigate to login page in most ways there is no error happened
  ///in our case we will handle navigation errors.
  Either<Failure,void> navigateToRegister(BuildContext context);
}
