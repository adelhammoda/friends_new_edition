

import 'package:dartz/dartz.dart';

import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';

abstract class HomePageRepository{
  ///fetch all offers from database and convert it to list of offers
  Future<Either<Failure,List<OfferEntity>>> fetchAllOffers();
  ///add offers to favorite locally.
  Future<Either<Failure,bool>> addToFavorite({required OfferEntity offer});
  ///search in favorites locally and return list of results.
  Either<Failure,List<OfferEntity>> searchOffers({required String searchKey});
  ///get offer owner data. Offer owner is user so the result will be user.
 Future<Either<Failure,UserEntity>> getUserData({required String userId});
}