

import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/features/offer/domain/repositories/offer_page_repository.dart';

 class FetchAllOffersUseCase{
  final OfferPageRepository repository;

  const FetchAllOffersUseCase(this.repository);

  Future<Either<Failure,List<OfferEntity>>> call()async=>await repository.fetchAllOffers();
}