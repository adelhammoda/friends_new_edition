


import 'package:dartz/dartz.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/failure/failure.dart';

abstract class HomePageRepository {
  Future<Either<Failure,UserEntity>> getCurrentUser();
}