import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/failure/failure.dart';


abstract class LoginRepositories {
  // ///auto login from cash memory
  // ///so we need to fetch email and password first
  // ///return [CashFailure] when we find no thing in cash memory.
  // ///return [FirebaseFailure] when we failed in login.
  // Future<Either<Failure,UserCredential>> tryAutoLogin();


  ///login with google account that supported by
  ///firebase auth .
  ///return [UserCredential] if the process completed successfully
  ///and return [Failure[ when error happened.
  Future<Either<Failure, UserCredential>> loginWithFacebook();

  ///login with google account that supported by
  ///firebase auth .
  ///return [UserCredential] if the process completed successfully
  ///and return [Failure[ when error happened.
  Future<Either<Failure, UserCredential>> loginWithApple();

  ///login with google account that supported by
  ///firebase auth .
  ///return [UserCredential] if the process completed successfully
  ///and return [Failure[ when error happened.
  Future<Either<Failure, UserCredential>> loginWithGoogle();

  ///login with email and password using firebase  packages
  ///to login.
  ///return [UserCredential] when completed successfully
  ///and return Type of [Failure] when error happened
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  ///navigate to forget password page and
  ///return no thing if the navigation completed successfully
  ///where it return  type of [Failure] when any exception happened.
  Either<Failure, void> forgetPassword(BuildContext context);

  ///navigate to create account page it's hold
  ///the email and password and pass them to {email controller}
  ///and {password controller}
  ///Return a [Failure]  when any navigation error happened
  Either<Failure, void> createAccount({
    required BuildContext context,
    required String email,
    required String password,
  });
}
