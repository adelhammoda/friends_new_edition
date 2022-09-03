import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widg'
    'ets.dart';

import '../../../../core/exception/failure.dart';
import '../entities/user_entity.dart';


abstract class LoginRepositories {
  ///login with google account that supported by
  ///firebase auth .
  ///return [UserCredential] if the process completed successfully
  ///and return [Failure[ when error happened.
  Future<Either<Failure,UserCredential>> loginWithFacebook();
  ///login with google account that supported by
  ///firebase auth .
  ///return [UserCredential] if the process completed successfully
  ///and return [Failure[ when error happened.
  Future<Either<Failure,UserCredential>> loginWithApple ();
  ///login with google account that supported by
  ///firebase auth .
  ///return [UserCredential] if the process completed successfully
  ///and return [Failure[ when error happened.
  Future<Either<Failure,UserCredential>> loginWithGoogle();
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
  Either<Failure, Null> forgetPassword(BuildContext context);
  ///navigate to create account page it's hold
  ///the email and password and pass them to {email controller}
  ///and {password controller}
  ///Return a [Failure]  when any navigation error happened
  Either<Failure, Null> createAccount({
  required String email,
    required String password,
});

  ///we need to cash user after he logged in successfully to
  ///auto log in in next time  he enter the app
  ///Return [Failure] when any cashing exception happened
  Future<Either<Failure,User>> cashUser(UserEntity user);
}
