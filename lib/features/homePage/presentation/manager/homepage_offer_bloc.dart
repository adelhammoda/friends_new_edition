import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/use_cases/add_to_favorite_use_case.dart';
import 'package:friends/features/homePage/domain/use_cases/fetch_all_offers_usecase.dart';
import 'package:friends/features/homePage/domain/use_cases/get_user_data_use_case.dart';
import 'package:friends/features/homePage/domain/use_cases/load_favorite_use_cases.dart';
import 'package:friends/features/homePage/domain/use_cases/navigate_to_details_page_usecases.dart';
import 'package:friends/features/homePage/domain/use_cases/remove_from_fovorite_usecase.dart';
import 'package:friends/features/homePage/domain/use_cases/search_offers_use_case.dart';


part 'homepage_offer_event.dart';
part 'homepage_offer_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState > {
  final SearchOffersUseCase searchOffersUseCase;
  final GetUserDataUseCases getUserDataUseCases;
  final FetchAllOffersUseCase fetchAllOffersUseCase;
  final AddToFavoriteUseCase addToFavoriteUseCase;
  final LoadFavoriteUseCases loadFavoriteUseCases;
  final NavigateToDetailsUseCases navigateToDetailsUseCases;
  final RemoveFromFavoriteUseCase removerFromFavoriteUseCases;
  List<OfferEntity> offers = [];
  Set<String> favorite = {};

  HomepageBloc({
    required this.searchOffersUseCase,
    required this.getUserDataUseCases,
    required this.fetchAllOffersUseCase,
    required this.addToFavoriteUseCase,
    required this.loadFavoriteUseCases,
    required this.navigateToDetailsUseCases,
    required this.removerFromFavoriteUseCases,
  }) : super(HomepageInitialState()) {
    on<HomepageEvent>((event, emit) {
      switch (event.runtimeType) {
        case HomepageLoadOffersEvent:
          loadOffersEvent(
            event as HomepageLoadOffersEvent,
          );
          break;
        case HomepageRefreshEvent:
          refreshOffers(event as HomepageRefreshEvent);
          break;
        case HomepageSearchEvent:
          searchEvent(
            event as HomepageSearchEvent,
          );
          break;
        case HomepageLoadFavoriteEvent:
          loadFavorite(
            event as HomepageLoadFavoriteEvent,
          );
          break;
        case HomepageNavigateToDetailsEvent:
          navigationToDetailsEvent(
            event as HomepageNavigateToDetailsEvent,
          );
          break;
        case HomepageAddToFavoriteEvent:
          addToFavorite(
            event as HomepageAddToFavoriteEvent,
          );
          break;
        case HomepageRemoverFromFavoriteEvent:
          removeFromFavorite(event as HomepageRemoverFromFavoriteEvent);
          break;
        default:
          emit(HomepageInitialState());
          break;
      }
    });
  }

  void loadOffersEvent(HomepageLoadOffersEvent event) async {

    // ignore: invalid_use_of_visible_for_testing_member
    emit(HomepageLoadingState());
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    Either<Failure, Set<String>> favoriteOffers = await loadFavoriteUseCases();
    res.fold(
        // ignore: invalid_use_of_visible_for_testing_member
        (failure) => emit(HomepageErrorState(failure)),
        (offers) {
          this.offers = offers;
          favoriteOffers.fold(
            // ignore: invalid_use_of_visible_for_testing_member
            (failure) =>

                // ignore: invalid_use_of_visible_for_testing_member
                emit(HomepageErrorState(failure)),
            (favoriteOffers)
            {
              favorite = favoriteOffers;
              // ignore: invalid_use_of_visible_for_testing_member
              emit(HomepageLoadedState(offers, favoriteOffers));});});
  }

  void searchEvent(HomepageSearchEvent event) async {
      Either<Failure, List<OfferEntity>> res = searchOffersUseCase(
          offers: offers, searchKey: event.searchKey);
      res.fold(
          // ignore: invalid_use_of_visible_for_testing_member
          (failure) => emit(HomepageErrorState(failure)),
          (offers) =>
              // ignore: invalid_use_of_visible_for_testing_member
              emit(HomepageLoadedState(offers, favorite)));
    }

    Future<void> loadFavorite(HomepageLoadFavoriteEvent event) async {
        Either<Failure, Set<String>> res = await loadFavoriteUseCases();
        // ignore: invalid_use_of_visible_for_testing_member
        res.fold((failure) => emit(HomepageErrorState(failure)),

            (favoriteOffers) {
          favorite = favoriteOffers;
              // ignore: invalid_use_of_visible_for_testing_member
              emit(HomepageLoadedState(offers, favoriteOffers));
            });
    }



  Future<void> refreshOffers(HomepageRefreshEvent event) async {
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    Either<Failure, Set<String>> favoriteOffers = await loadFavoriteUseCases();
    res.fold(
      // ignore: invalid_use_of_visible_for_testing_member
            (failure) => emit(HomepageErrorState(failure)),
            (offers) {
          this.offers = offers;
          favoriteOffers.fold(
            // ignore: invalid_use_of_visible_for_testing_member
                  (failure) =>

              // ignore: invalid_use_of_visible_for_testing_member
              emit(HomepageErrorState(failure)),
                  (favoriteOffers)
              {
                favorite = favoriteOffers;
                // ignore: invalid_use_of_visible_for_testing_member
                emit(HomepageLoadedState(offers, favoriteOffers));});});
  }

    void navigationToDetailsEvent(HomepageNavigateToDetailsEvent event) async {
      navigateToDetailsUseCases(context: event.context, offer: event.offer);
    }

    Future<void> addToFavorite(HomepageAddToFavoriteEvent event) async {
      Either<Failure, void> res = await addToFavoriteUseCase(offer: event.offerId);
      // ignore: invalid_use_of_visible_for_testing_member
      res.fold((failure) => emit(HomepageErrorState(failure)),
          (_) {
        favorite.add(event.offerId);
        // ignore: invalid_use_of_visible_for_testing_member
        emit(HomepageLoadedState(offers, favorite));});

    }

    void removeFromFavorite(HomepageRemoverFromFavoriteEvent event) async {
      final res = await removerFromFavoriteUseCases(
          offerId: event.offerId);
      res.fold(
          // ignore: invalid_use_of_visible_for_testing_member
          (failure) => emit(HomepageErrorState(failure)),
          (_){
            favorite.remove(event.offerId);

            // ignore: invalid_use_of_visible_for_testing_member
            emit(HomepageLoadedState(offers, favorite));} );
    }
  }
