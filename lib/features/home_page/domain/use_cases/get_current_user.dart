


import 'package:dartz/dartz.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/home_page/domain/repositories/home_page_repository.dart';

class GetCurrentUserUseCases{
  final HomePageRepository repository;

  GetCurrentUserUseCases(this.repository);

  Future<Either<Failure,UserEntity>> call()async=>await repository.getCurrentUser();
}