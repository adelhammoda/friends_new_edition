import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/status_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/home_page/data/data_sources/home_page_local_data_source.dart';
import 'package:friends/features/home_page/domain/repositories/home_page_repository.dart';

class HomePageRepositoryImpl extends HomePageRepository {
  final HomePageLocalDataSource local;

  HomePageRepositoryImpl(this.local);

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      UserEntity user = await local.fetchUserFromCash();
      return Right(user);
    } on UserNotFoundInLocalStorageException catch (e) {
      debugPrint(e.toString());
      return const Left( UserNotFoundInLocalStorageFailure(
          message: StringManager.noUserInLocalStorage,
          statusCode: StatusCode.localStorage));
    }catch(e){
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }
}
