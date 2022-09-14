import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/statuse_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/navigation/navigator.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/core/routes/routes.dart';
import 'package:friends/features/register/data/data_sources/register_local_data_source.dart';
import 'package:friends/features/register/data/data_sources/register_remote_data_source.dart';
import 'package:friends/features/register/domain/repositories/register_repositories.dart';

import '../../../../core/device_info/device_info.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_models.dart';

class RegisterRepositoriesImpl extends RegisterRepositories {
  final RegisterLocalDataSource localDataSource;
  final RegisterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final DeviceInfo deviceInfo;

  RegisterRepositoriesImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.deviceInfo,
    required this.networkInfo,
  });

  @override
  Either<Failure, void> alreadyHaveAccountNavigator(BuildContext context) {
    try {
      Go.to(context, Routes.register);
      return const Right(null);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return  const Left(NavigationFailure(
          message: StringManager.navigatorErrorMessage,
          statusCode: StatusCode.navigation));
    }
  }

  @override
  Future<Either<Failure, void>> createUser({required UserEntity user}) async {
    try {
      await remoteDataSource.createUser(user: user as UserModel);
      localDataSource.cashUser(user: user);
      return const Right(null);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(FirebaseFailure(
          statusCode: StatusCode.firebase,
          message: e.message ?? StringManager.createUserErrorMessage));
    } on CashException catch (e) {
      debugPrint(e.message);
      return Left(CashFailure(
        message: e.message,
        statusCode: e.code,
      ));
    }on Exception catch(e){
      debugPrint(e.toString());
      return const Left( UnKnownFailure(
        message: StringManager.registerUnknownErrorMessage,statusCode: StatusCode.unknown
      ));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithApple() {
    // TODO: implement registerWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithEmailAndPassword(
      {required UserEntity user}) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithFacebook() {
    // TODO: implement registerWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithGoogle() {
    // TODO: implement registerWithGoogle
    throw UnimplementedError();
  }
}
