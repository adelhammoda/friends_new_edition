import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/repositories/offer_page_repository.dart';

class LoadFavoriteUseCases {
  final OfferPageRepository homePageRepository;

  LoadFavoriteUseCases(this.homePageRepository);

  Future<Either<Failure, Set<String>>> call() async =>
      await homePageRepository.getFavoriteOffers();
}
