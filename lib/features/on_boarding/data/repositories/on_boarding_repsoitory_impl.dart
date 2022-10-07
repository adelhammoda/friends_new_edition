import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/device_info/device_info.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/statuse_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/navigation/navigator.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/core/routes/routes.dart';
import 'package:friends/features/login/data/models/user_model.dart';
import 'package:friends/features/on_boarding/data/data_sources/on_boarding_local_datasource.dart';
import 'package:friends/features/on_boarding/data/data_sources/onboarding_remote_datasource.dart';
import 'package:friends/features/on_boarding/domain/repositories/on_boarding_repository.dart';


class OnBoardingRepositoryImpl extends OnBoardingRepository {
  final OnBoardingRemoteDataSource remoteDataSource;
  final OnBoardingLocalDataSource localDataSource;
  final DeviceInfo deviceInfo;
  final NetworkInfo networkConnection;
  OnBoardingRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.deviceInfo,
      required this.networkConnection});

  @override
  Either<Failure, void> navigateToLogin(BuildContext context) {
    try {
      Go.to(context, Routes.login);
      return const Right(null);
    } on Exception catch (_) {
      return const Left(NavigationFailure(
          message: StringManager.navigatorErrorMessage,
          statusCode: StatusCode.navigation));
    }
  }

  @override
  Either<Failure, void> navigateToRegister(BuildContext context) {
    try {
      Go.to(context, Routes.register);
      return const Right(null);
    } on Exception catch (_) {
      return const Left(NavigationFailure(
          message: StringManager.navigatorErrorMessage,
          statusCode: StatusCode.navigation));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> tryAutoLogin() async{
    try {
    bool hasInternet  =await  networkConnection.isConnected;
    if(hasInternet) {
      String deviceId =await deviceInfo.getDeviceId();
      UserModel user = await localDataSource.getCashedUser();
      String? password = (await localDataSource.getUserEmailAndPassword())[ConstantManager.passwordKeyForMap];
      if(password != null){
       UserCredential userCredential =await remoteDataSource.loginUser(userModel: user, password: password, userDeviceId: deviceId);
       return Right(userCredential);
      }else{
        throw AutoLoginException(
          message: StringManager.missingDataErrorMessage,
        );
      }
    }else{
      throw NetworkException();
    }
    } on NetworkException catch(e){
      debugPrint(e.message);
      return Left(NetworkFailure(
        message: e.message,
        statusCode: StatusCode.network
      ));
    } on AutoLoginException catch(e){
      debugPrint(e.message);
      return const Left(AutoLoginFailure(
        statusCode: StatusCode.autoLogin,
        message: StringManager.autoLoginErrorMessage
      ));
    } on DeviceInfoException catch(e){
      debugPrint(e.message);
      return Left(DeviceInfoFailure(
        message: e.message,
        statusCode: StatusCode.deviceInfo
      ));
    } on CashException catch(e){
      debugPrint(e.message);
      return Left(CashFailure(
        message: e.message,
        statusCode: StatusCode.cash
      ));
    }on Exception catch(e){
      debugPrint(e.toString());
      return const Left(AutoLoginFailure(
        message: StringManager.autoLoginUnknownErrorMessage,
        statusCode: StatusCode.autoLogin
      ));
    }
  }
}
