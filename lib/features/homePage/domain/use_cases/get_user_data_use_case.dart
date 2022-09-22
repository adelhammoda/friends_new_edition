import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';

 class GetUserDataUseCases {
  final HomePageRepository repository;

  const  GetUserDataUseCases(this.repository);

  Future<Either<Failure, UserEntity>> call({required String userId}) async =>
      await repository.getUserData(userId: userId);
}
