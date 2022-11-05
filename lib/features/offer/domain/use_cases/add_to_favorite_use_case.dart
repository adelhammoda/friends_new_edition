



import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/repositories/offer_page_repository.dart';

 class AddToFavoriteUseCase{
  final OfferPageRepository repository;

  const AddToFavoriteUseCase(this.repository);

  Future<Either<Failure,void>> call({required String offer})async=>await repository.addToFavorite(offer: offer);

}