import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';

class RemoveFromFavoriteUseCase {
  final HomePageRepository repository;

  const RemoveFromFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call({required String offerId}) async =>
      await repository.removeFromFavorite(offerId: offerId);
}
