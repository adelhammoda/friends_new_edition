



import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';

 class AddToFavoriteUseCase{
  final HomePageRepository repository;

  const AddToFavoriteUseCase(this.repository);

  Future<Either<Failure,void>> call({required OfferEntity offer})async=>await repository.addToFavorite(offer: offer);

}