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
import '../../../login/data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

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

  Future<Either<Failure,UserCredential>> _register(
      BuildContext context,
      Future<UserCredential> Function() registerProvider
      )async{
    try{
      bool hasNetwork = await networkInfo.isConnected;
      print("$hasNetwork+'''''''''''''''''''''''''''''");
      if(hasNetwork) {
        final UserCredential userCredential = await registerProvider();
        return Right(userCredential);
      }else{
        throw NetworkException(
          message: StringManager.networkErrorMessage,
          code: StatusCode.network
        );
      }

    }on FirebaseException catch (e) {
      remoteDataSource.safelyDeleteUserAccount();
      debugPrint(e.message);
      debugPrint(e.code);
      return Left(FirebaseFailure(
          message: e.message??StringManager.createUserErrorMessage,
          statusCode: StatusCode.firebase
      ));
    } on DeviceInfoException catch(e){
      debugPrint(e.message);
      return Left(DeviceInfoFailure(
          statusCode: StatusCode.deviceInfo,
          message: e.message
      ));
    } on CreateUserException catch(e){
      remoteDataSource.safelyDeleteUserAccount();
      debugPrint(e.message);
      return Left(CreateUserFailure(
          message: e.message,
          statusCode: StatusCode.createUser
      ));
    } on CashException catch(e){
      remoteDataSource.safelyDeleteUserAccount();
      debugPrint(e.message);
      return Left(CashFailure(
          statusCode: StatusCode.cash,
          message: e.message
      ));
    } on NetworkException catch(e){
      debugPrint(e.message);
      return Left(NetworkFailure(
        message: e.message,
        statusCode: StatusCode.network
      ));
    }
    on Exception catch(e){
      remoteDataSource.safelyDeleteUserAccount();
      debugPrint(e.toString());
      return const Left(UnKnownFailure(
          message: StringManager.createUserErrorMessage,
          statusCode: StatusCode.unknown
      ));
    }
  }

  @override
  Either<Failure, void> alreadyHaveAccountNavigator(BuildContext context) {
    try {
      Go.to(context, Routes.login);
      return const Right(null);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return  const Left(NavigationFailure(
          message: StringManager.navigatorErrorMessage,
          statusCode: StatusCode.navigation));
    }
  }


  @override
  Future<Either<Failure, UserCredential>> registerWithApple(BuildContext context)async {
  return _register(context,()async {
     UserCredential userCredential = await remoteDataSource.registerWithApple();
     String userPhoneId = await deviceInfo.getDeviceId();
     await remoteDataSource.createUser(user: UserModel.fromUserCredential(userCredential: userCredential), userPhoneId: userPhoneId);
     await localDataSource.cashUser(user: UserModel.fromUserCredential(userCredential: userCredential));
     return userCredential;
   });

  }

  @override
  Future<Either<Failure, UserCredential>> registerWithEmailAndPassword(BuildContext context,
      {required UserEntity user,required String password}) async{
   return _register(context,()async{
     final UserCredential userCredential = await remoteDataSource.registerWithEmailAndPassword(email: user.email, password: password);
     final String userPhoneId = await  deviceInfo.getDeviceId();
     await remoteDataSource.createUser(user: UserModel.fromUserCredential(userCredential: userCredential), userPhoneId: userPhoneId);
     await localDataSource.cashUser(user: UserModel.fromUserCredential(userCredential: userCredential));
     return userCredential;
   });
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithFacebook(BuildContext context) {
    return _register(context,() async{
      UserCredential userCredential = await remoteDataSource.registerWithFacebook();
      String userPhoneId = await deviceInfo.getDeviceId();

      await remoteDataSource.createUser(user: UserModel.fromUserCredential(userCredential: userCredential), userPhoneId: userPhoneId);
      await localDataSource.cashUser(user: UserModel.fromUserCredential(userCredential: userCredential));
      return userCredential;
    });
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithGoogle(BuildContext context) {
    return _register(context,() async{
      UserCredential userCredential = await remoteDataSource.registerWithGoogle();
      String userPhoneId = await deviceInfo.getDeviceId();
      await remoteDataSource.createUser(user: UserModel.fromUserCredential(userCredential: userCredential), userPhoneId: userPhoneId);
      await localDataSource.cashUser(user: UserModel.fromUserCredential(userCredential: userCredential));
      return userCredential;
    });
  }

}
