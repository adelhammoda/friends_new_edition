import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/statuse_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/forget_password/presentation/pages/forget_password_page.dart';
import 'package:friends/features/login/data/data_sources/login_local_data_source.dart';
import 'package:friends/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/navigation/navigator.dart';
import '../../../../core/network/network_info.dart';
import '../../../register/presentation/pages/register.dart';

class LoginRepositoriesImpl implements LoginRepositories {
  LoginRemoteDataSource remote;
  LoginLocalDataSource local;
  NetworkInfo networkInfo;

  LoginRepositoriesImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  Future<Either<Failure, UserCredential>> _signIn(
      Future<UserCredential> Function() f) async {
    try {
      if (await networkInfo.isConnected) {
        UserCredential credential = await f.call();
        return Right(credential);
      } else {
        throw NetworkException();
      }
    } on CashException catch (e) {
      debugPrint(e.message);
      return const Left(CashFailure(
          message: StringManager.cashErrorMessage,
          statusCode: StatusCode.cash));
    } on NetworkException catch (e) {
      debugPrint(e.message);
      return const Left(NetworkFailure(
          statusCode: StatusCode.network,
          message: StringManager.networkErrorMessage));
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(FirebaseFailure(
          message: e.message ?? StringManager.authErrorMessage,
          statusCode: StatusCode.firebase));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(UnKnownFailure(
          message: StringManager.authErrorMessage,
          statusCode: StatusCode.firebase));
    }
  }

  @override
  Either<Failure, void> createAccount(
      {required BuildContext context,
      required String email,
      required String password}) {
    try {
      Go.to(context, const Register(), null);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return const Left(NavigationFailure(
          message: StringManager.navigatorErrorMessage,
          statusCode: StatusCode.navigation));
    }
  }

  @override
  Either<Failure, void> forgetPassword(BuildContext context) {
    try {
      Go.to(context, const ForgetPasswordPage(), null);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return const Left(NavigationFailure(
          message: StringManager.navigatorErrorMessage,
          statusCode: StatusCode.navigation));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithApple() => _signIn(() {
      return FirebaseAuth.instance.signInWithAuthProvider(AppleAuthProvider());
    });

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password})  => _signIn(() async {
      UserCredential u = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      local.cashUserEmailAndPassword(email: email, password: password);
      return u;
    });

  @override
  Future<Either<Failure, UserCredential>> loginWithFacebook()  => _signIn(() =>
        FirebaseAuth.instance.signInWithAuthProvider(FacebookAuthProvider()));

  @override
  Future<Either<Failure, UserCredential>> loginWithGoogle() => _signIn(() =>
        FirebaseAuth.instance.signInWithAuthProvider(GoogleAuthProvider()));


}
