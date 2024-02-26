import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/repositories/offer_page_repository.dart';
import 'package:friends/core/common_entity/user_entity.dart';

 class GetUserDataUseCases {
  final OfferPageRepository repository;

  const  GetUserDataUseCases(this.repository);

  Future<Either<Failure, UserEntity>> call({required String userId}) async =>
      await repository.getUserData(userId: userId);
}
