import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/features/offer/domain/use_cases/add_to_favorite_use_case.dart';
import 'package:friends/features/offer/domain/use_cases/fetch_all_offers_usecase.dart';
import 'package:friends/features/offer/domain/use_cases/get_user_data_use_case.dart';
import 'package:friends/features/offer/domain/use_cases/load_favorite_use_cases.dart';
import 'package:friends/features/offer/domain/use_cases/navigate_to_details_page_usecases.dart';
import 'package:friends/features/offer/domain/use_cases/remove_from_fovorite_usecase.dart';
import 'package:friends/features/offer/domain/use_cases/search_offers_use_case.dart';
import 'package:friends/core/common_entity/user_entity.dart';

part 'offerpage_offer_event.dart';

part 'offerpage_offer_state.dart';

class OfferPageBloc extends Bloc<OfferPageEvent, OfferPageState> {
  final SearchOffersUseCase searchOffersUseCase;
  final GetUserDataUseCases getUserDataUseCases;
  final FetchAllOffersUseCase fetchAllOffersUseCase;
  final AddToFavoriteUseCase addToFavoriteUseCase;
  final LoadFavoriteUseCases loadFavoriteUseCases;
  final NavigateToDetailsUseCases navigateToDetailsUseCases;
  final RemoveFromFavoriteUseCase removerFromFavoriteUseCases;
  List<OfferEntity> offers = [];
  Set<String> favorite = {};

  OfferPageBloc({
    required this.searchOffersUseCase,
    required this.getUserDataUseCases,
    required this.fetchAllOffersUseCase,
    required this.addToFavoriteUseCase,
    required this.loadFavoriteUseCases,
    required this.navigateToDetailsUseCases,
    required this.removerFromFavoriteUseCases,
  }) : super(OfferPageInitialState()) {
    on<OfferPageEvent>((event, emit) {
      switch (event.runtimeType) {
        case OfferPageLoadOffersEvent:
          loadOffersEvent(
            event as OfferPageLoadOffersEvent,
          );
          break;
        case OfferPageRefreshEvent:
          refreshOffers(event as OfferPageRefreshEvent);
          break;
        case OfferPageSearchEvent:
          searchEvent(
            event as OfferPageSearchEvent,
          );
          break;
        case OfferPageLoadFavoriteEvent:
          loadFavorite(
            event as OfferPageLoadFavoriteEvent,
          );
          break;
        case OfferPageNavigateToDetailsEvent:
          navigationToDetailsEvent(
            event as OfferPageNavigateToDetailsEvent,
          );
          break;
        case OfferPageAddToFavoriteEvent:
          addToFavorite(
            event as OfferPageAddToFavoriteEvent,
          );
          break;
        case OfferPageRemoverFromFavoriteEvent:
          removeFromFavorite(event as OfferPageRemoverFromFavoriteEvent);
          break;
        case OfferPageLoadUserDetailsEvent:
          loadUserDetails(event as OfferPageLoadUserDetailsEvent);
          break;
        default:
          emit(OfferPageInitialState());
          break;
      }
    });
  }

  void loadOffersEvent(OfferPageLoadOffersEvent event) async {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(OfferPageLoadingState());
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    Either<Failure, Set<String>> favoriteOffers = await loadFavoriteUseCases();
    res.fold(
        // ignore: invalid_use_of_visible_for_testing_member
        (failure) => emit(OfferPageErrorState(failure)), (offers) {
      this.offers = offers;
      favoriteOffers.fold(
          // ignore: invalid_use_of_visible_for_testing_member
          (failure) =>

              // ignore: invalid_use_of_visible_for_testing_member
              emit(OfferPageErrorState(failure)), (favoriteOffers) {
        favorite = favoriteOffers;
        // ignore: invalid_use_of_visible_for_testing_member
        emit(OfferPageLoadedState(offers, favoriteOffers));
      });
    });
  }

  void searchEvent(OfferPageSearchEvent event) async {
    Either<Failure, List<OfferEntity>> res =
        searchOffersUseCase(offers: offers, searchKey: event.searchKey);
    res.fold(
        // ignore: invalid_use_of_visible_for_testing_member
        (failure) => emit(OfferPageErrorState(failure)),
        (offers) =>
            // ignore: invalid_use_of_visible_for_testing_member
            emit(OfferPageLoadedState(offers, favorite)));
  }

  Future<void> loadFavorite(OfferPageLoadFavoriteEvent event) async {
    Either<Failure, Set<String>> res = await loadFavoriteUseCases();
    // ignore: invalid_use_of_visible_for_testing_member
    res.fold((failure) => emit(OfferPageErrorState(failure)), (favoriteOffers) {
      favorite = favoriteOffers;
      // ignore: invalid_use_of_visible_for_testing_member
      emit(OfferPageLoadedState(offers, favoriteOffers));
    });
  }

  Future<void> refreshOffers(OfferPageRefreshEvent event) async {
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    Either<Failure, Set<String>> favoriteOffers = await loadFavoriteUseCases();
    res.fold(
        // ignore: invalid_use_of_visible_for_testing_member
        (failure) => emit(OfferPageErrorState(failure)), (offers) {
      this.offers = offers;
      favoriteOffers.fold(
          // ignore: invalid_use_of_visible_for_testing_member
          (failure) =>

              // ignore: invalid_use_of_visible_for_testing_member
              emit(OfferPageErrorState(failure)), (favoriteOffers) {
        favorite = favoriteOffers;
        // ignore: invalid_use_of_visible_for_testing_member
        emit(OfferPageLoadedState(offers, favoriteOffers));
      });
    });
  }

  void navigationToDetailsEvent(OfferPageNavigateToDetailsEvent event) async {
    navigateToDetailsUseCases(
        context: event.context, offer: event.offer, bloc: event.blocValue);
  }

  Future<void> addToFavorite(OfferPageAddToFavoriteEvent event) async {
    Either<Failure, void> res =
        await addToFavoriteUseCase(offer: event.offerId);
    // ignore: invalid_use_of_visible_for_testing_member
    res.fold((failure) => emit(OfferPageErrorState(failure)), (_) {
      favorite.add(event.offerId);
      // ignore: invalid_use_of_visible_for_testing_member
      emit(OfferPageLoadedState(offers, favorite));
    });
  }

  void removeFromFavorite(OfferPageRemoverFromFavoriteEvent event) async {
    final res = await removerFromFavoriteUseCases(offerId: event.offerId);
    res.fold(
        // ignore: invalid_use_of_visible_for_testing_member
        (failure) => emit(OfferPageErrorState(failure)), (_) {
      favorite.remove(event.offerId);

      // ignore: invalid_use_of_visible_for_testing_member
      emit(OfferPageLoadedState(offers, favorite));
    });
  }

  Future<UserEntity?> loadUserDetails(
      OfferPageLoadUserDetailsEvent event) async {
    final Either<Failure, UserEntity> res =
        await getUserDataUseCases(userId: event.userId);
    return res.fold((failure) => null, (user) => user);
  }
}
