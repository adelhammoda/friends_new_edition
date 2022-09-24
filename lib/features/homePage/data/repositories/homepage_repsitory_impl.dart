import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/statuse_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/features/homePage/data/data_sources/homepage_local_data_source.dart';
import 'package:friends/features/homePage/data/data_sources/homepage_remote_data_source.dart';
import 'package:friends/features/homePage/data/models/offer_model.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';

class HomepageRepositoryImpl extends HomePageRepository {
  final HomePageRemoteDataSource remote;
  final HomepageLocalDataSource local;
  final NetworkInfo networkInfo;

  HomepageRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> addToFavorite(
      {required OfferEntity offer}) async {
    try {
      bool isMoved = await local.moveToFavorite(offer: offer as OfferModel);
      if (isMoved) {
        return const Right(null);
      }
      else {
        throw CashException(
          message: StringManager.addingToCashFailedErrorMessage,
        );
      }
    } on CashException catch (e) {
      return Left(CashFailure(
          message: e.message,
          statusCode: StatusCode.cash
      ));
    } on FormatException catch (e) {
      return  Left(BadFormatFailure(
          message: e.message
      ));
    } catch (e) {
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, List<OfferEntity>>> fetchAllOffers() async {
    try {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        List<OfferEntity> offers = await remote.fetchOffers();
        return Right(offers);
      }else{
        throw const NetworkFailure();
      }

    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(FirebaseFailure(
          message: e.message ?? StringManager.cantFetchUserErrorMessage));
    } on NetworkException catch (e) {
      debugPrint(e.message);
      return Left(NetworkFailure(message: e.message));
    } on BadFormatException catch (e) {
      return Left(BadFormatFailure(message: e.message,));
    }catch(e){
      return const Left( UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(
      {required String userId}) async {
    try{
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        UserEntity user = await remote.fetchUser(userId: userId);
        return Right(user);
      }else{
        throw const NetworkFailure();
      }
    }on FirebaseException catch (e) {
      debugPrint(e.message);
      return Left(FirebaseFailure(
          message: e.message ?? StringManager.cantFetchUserErrorMessage));
    } on NetworkException catch (e) {
      debugPrint(e.message);
      return Left(NetworkFailure(message: e.message));
    } on BadFormatException catch (e) {
      return Left(BadFormatFailure(message: e.message,));
    }catch(e){
      return const Left( UnKnownFailure());
    }
  }

  @override
  Either<Failure, List<OfferEntity>> searchOffers(
      {required String searchKey, required List<OfferEntity> offers}) {
    try{
      List<OfferEntity> result =  local.searchOffer(offers: offers, searchKey: searchKey);
      return Right(result);
    }on NoDataException catch(e){
      debugPrint(e.message);
      return  Left(NoDataFailure(message: e.message));
    } catch(e){
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, List<OfferEntity>>> getFavoriteOffers() async{
    try{
      List<OfferEntity> result =await local.getAllFavorite();
      return Right(result);
    }on CashException catch(e){
      return Left(CashFailure(message:e.message));
    }on NoDataException catch(e){
      return Left(NoDataFailure(message: e.message));
    }catch(e){
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }
}
