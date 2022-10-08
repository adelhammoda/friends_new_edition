import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/features/offer/domain/repositories/home_page_repository.dart';

class SearchOffersUseCase {
  final OfferPageRepository repository;

  const SearchOffersUseCase(this.repository);

  Either<Failure, List<OfferEntity>> call(
          {required String searchKey, required List<OfferEntity> offers}) =>
      repository.searchOffers(searchKey: searchKey, offers: offers);
}
