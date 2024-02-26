

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';

abstract class OfferPageRepository{
  ///fetch all offers from database and convert it to list of offers
  Future<Either<Failure,List<OfferEntity>>> fetchAllOffers();
  ///add offers to favorite locally.
  Future<Either<Failure,void>> addToFavorite({required String offer});
  ///search in favorites locally and return list of results.
  Either<Failure,List<OfferEntity>> searchOffers({required String searchKey,required List<OfferEntity> offers});
  ///get offer owner data. Offer owner is user so the result will be user.
 Future<Either<Failure,UserEntity>> getUserData({required String userId});
 ///load all favorite offers locally using hive.
 Future<Either<Failure,Set<String>>> getFavoriteOffers();
 ///navigate to details page
Either<Failure,void> navigateToDetailsPage({required BuildContext context,required OfferEntity offer,required OfferPageBloc bloc});

 Future<Either<Failure,void>> removeFromFavorite({required String offerId}) ;
}