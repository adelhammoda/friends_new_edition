import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';

class LoadFavoriteUseCases {
  final HomePageRepository homePageRepository;

  LoadFavoriteUseCases(this.homePageRepository);

  Future<Either<Failure, List<OfferEntity>>> call() async =>
      await homePageRepository.getFavoriteOffers();
}
