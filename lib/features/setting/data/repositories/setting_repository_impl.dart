import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/log/log.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/features/setting/data/data_sources/setting_local_data_source.dart';
import 'package:friends/features/setting/data/data_sources/setting_remote_data_source.dart';
import 'package:friends/features/setting/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final NetworkInfo networkInfo;
  final SettingLocalDataSource local;
  final SettingRemoteDataSource remote;

  SettingRepositoryImpl({
    required this.local,
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> deleteAccount(
      {required String userId, required BuildContext context}) async {
    PrintLog.call(tag: "Delete account", message: "Checking network...");
    bool hasNetwork = await networkInfo.isConnected;

    try {
      if (hasNetwork) {
        PrintLog.call(tag: "Delete account", message: "delete account from local repository");
        await local.deleteAccountFromLocalRepository();
        PrintLog.call(tag: "Delete account", message: "delete account from firebase");
        await remote.deleteAccount(userId: userId, context: context);
        PrintLog.call(tag: "Delete account", message: "The user is deleted successfully 👍");
        return const Right(null);
      }else{
        throw NetworkException();
      }
    } on NetworkException catch (e) {
      PrintLog.call(tag: "Delete account", message: "the user don't have network",error: e.message);
      return const Left(NetworkFailure());
    }catch(e){
      PrintLog.call(tag: "Delete account", message: "Unknown error happened",error: e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout(
      {required String userId, required BuildContext context})async {
    String tag = "logout";
    PrintLog.call(tag: tag, message: "Checking network...");
    bool hasNetwork = await networkInfo.isConnected;
    try {
      if (hasNetwork) {
        PrintLog.call(tag: tag, message: "delete account from local repository");
        await local.deleteAccountFromLocalRepository();
        PrintLog.call(tag:tag, message: "logout from firebase");
        await remote.logout(userId: userId, context: context);
        PrintLog.call(tag: tag, message: "The user is logout successfully 👍");
        return const Right(null);
      }else{
        throw NetworkException();
      }
    } on NetworkException catch (e) {
      PrintLog.call(tag: tag, message: "the user don't have network",error: e.message);
      return const Left(NetworkFailure());
    }catch(e){
      PrintLog.call(tag: tag, message: "Unknown error happened",error: e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> switchTheme({required bool dark}) async{
      const String tag = "Switching theme";
    try {
      PrintLog.call(tag: tag, message: "Save user option in local storage");
      local.switchTheme(isDark: dark);
      PrintLog.call(tag: tag, message: "The theme is switched successfully to ${dark?"Dark Theme":"Light Theme"}👍");
      return const Right(null);
    }  catch (e) {
      PrintLog.call(tag: tag, message: "Unknown error happened",error: e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> switchLanguage({required String local}) async{
    const String tag = "Switching Language";
    try {
      PrintLog.call(tag: tag, message: "Save user option in local storage");
      this.local.switchLanguage(local: local);
      PrintLog.call(tag: tag, message: "The language is switched successfully to $local 👍");
      return const Right(null);
    }  catch (e) {
      PrintLog.call(tag: tag, message: "Unknown error happened",error: e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> loadUserPreferences() async {
    try{
    String lang =  await  local.getLanguage();
    ThemeMode theme = await local.getTheme();
    Map<String , dynamic> res = {
      ConstantManager.local:lang,
      ConstantManager.theme:theme,
    };
    return Right(res);
    }catch(e){
      return const Left(UnKnownFailure());
    }
  }
}
