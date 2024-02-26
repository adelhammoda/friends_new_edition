import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/statuse_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/routes/routes.dart';
import 'package:friends/features/login/data/data_sources/login_local_data_source.dart';
import 'package:friends/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/navigation/navigator.dart';
import '../../../../core/network/network_info.dart';


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
          statusCode: StatusCode.unknown));
    }
  }

  @override
  Either<Failure, void> createAccount(
      {required BuildContext context,
      required String email,
      required String password}) {
    try {
      Go.to(context,Routes.register);
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
      Go.to(context, Routes.forgetPassword);
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return const Left(NavigationFailure(
          message: StringManager.navigatorErrorMessage,
          statusCode: StatusCode.navigation));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithApple() => _signIn(()=>remote.loginWithApple());

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password})  => _signIn(() async {
      UserCredential u = await remote.loginWithEmailAndPassword(email: email, password: password);
      local.cashUserEmailAndPassword(email: email, password: password);
      return u;
    });

  @override
  Future<Either<Failure, UserCredential>> loginWithFacebook()  => _signIn(() =>
       remote.loginWithFacebook());

  @override
  Future<Either<Failure, UserCredential>> loginWithGoogle() => _signIn(() =>
        remote.loginWithGoogle());


}
