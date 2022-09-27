import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/use_cases/add_to_favorite_use_case.dart';
import 'package:friends/features/homePage/domain/use_cases/fetch_all_offers_usecase.dart';
import 'package:friends/features/homePage/domain/use_cases/get_user_data_use_case.dart';
import 'package:friends/features/homePage/domain/use_cases/load_favorite_use_cases.dart';
import 'package:friends/features/homePage/domain/use_cases/navigate_to_details_page_usecases.dart';
import 'package:friends/features/homePage/domain/use_cases/remove_from_fovorite_usecase.dart';
import 'package:friends/features/homePage/domain/use_cases/search_offers_use_case.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';

part 'homepage_event.dart';

part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final SearchOffersUseCase searchOffersUseCase;
  final GetUserDataUseCases getUserDataUseCases;
  final FetchAllOffersUseCase fetchAllOffersUseCase;
  final AddToFavoriteUseCase addToFavoriteUseCase;
  final LoadFavoriteUseCases loadFavoriteUseCases;
  final NavigateToDetailsUseCases navigateToDetailsUseCases;
  final RemoveFromFavoriteUseCase removerFromFavoriteUseCases;

  HomepageBloc({
    required this.searchOffersUseCase,
    required this.getUserDataUseCases,
    required this.fetchAllOffersUseCase,
    required this.addToFavoriteUseCase,
    required this.loadFavoriteUseCases,
    required this.navigateToDetailsUseCases,
    required this.removerFromFavoriteUseCases,
  }) : super(HomepageInitial()) {
    on<HomepageEvent>((event, emit) {
      switch (event.runtimeType) {
        case HomepageLoadOffersEvent:
          loadOffersEvent(event as HomepageLoadOffersEvent, );
          break;
        case HomepageRefreshEvent:
          refreshPage(event as HomepageRefreshEvent, );
          break;
        case HomepageSearchEvent:
          searchEvent(event as HomepageSearchEvent, );
          break;
        case HomepageLoadFavoriteEvent:
          loadFavorite(event as HomepageLoadFavoriteEvent, );
          break;
        case HomepageNavigateToDetailsEvent:
          navigationToDetailsEvent(
              event as HomepageNavigateToDetailsEvent, );
          break;
        case HomepageAddToFavoriteEvent:
          addToFavorite(event as HomepageAddToFavoriteEvent, );
          break;
        case HomepageRemoverFromFavoriteEvent:
          removeFromFavorite(event as HomepageRemoverFromFavoriteEvent);
          break;
        default:
          emit(HomepageInitial());
          break;
      }
    });
  }

  void loadOffersEvent(
      HomepageLoadOffersEvent event) async {
    emit(HomepageLoadingOffersState());
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    res.fold((failure) => emit(HomepageErrorState(failure)),
        (offers) => emit(HomepageOffersLoadedState(offers)));
  }

  void refreshPage(
      HomepageRefreshEvent event) async {
    emit(HomePageRefreshLoadingState());
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    res.fold((failure) => emit(HomepageErrorState(failure)),
        (offers) => emit(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emit(HomepageInitial());
    });
  }

  void searchEvent(
      HomepageSearchEvent event) async {
    Either<Failure, List<OfferEntity>> res = searchOffersUseCase(
        offers: event.oldOffers, searchKey: event.searchKey);
    res.fold((failure) => emit(HomepageErrorState(failure)),
        (offers) => emit(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emit(HomepageInitial());
    });
  }

  void loadFavorite(
      HomepageLoadFavoriteEvent event) async {
    Either<Failure, List<OfferEntity>> res = await loadFavoriteUseCases();
    res.fold((failure) => emit(HomepageErrorState(failure)),
        (offers) => emit(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emit(HomepageInitial());
    });
  }

  void navigationToDetailsEvent(HomepageNavigateToDetailsEvent event) async {
    navigateToDetailsUseCases(context: event.context, offer: event.offer);
  }

  void addToFavorite(
      HomepageAddToFavoriteEvent event) async {
    Either<Failure, void> res = await addToFavoriteUseCase(offer: event.offer);
    res.fold((failure) => emit(HomepageErrorState(failure)),
        (_) => emit(HomepageAddToFavoriteDoneAnimationState()));
    await Future.delayed(const Duration(microseconds: 100), () {
      emit(HomepageInitial());
    });
  }

  void removeFromFavorite(HomepageRemoverFromFavoriteEvent event) async {
    final res = await removerFromFavoriteUseCases(
        offerId: event.offerId, offers: event.offers);
    res.fold((failure) => emit(HomepageErrorState(failure)),
        (offers) => emit(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emit(HomepageInitial());
    });
  }
}
