

import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';


 class SearchOffersUseCase{
  final HomePageRepository repository;

  const SearchOffersUseCase(this.repository);

  Either<Failure,List<OfferEntity>> call({required String searchKey})=> repository.searchOffers(searchKey: searchKey);
}