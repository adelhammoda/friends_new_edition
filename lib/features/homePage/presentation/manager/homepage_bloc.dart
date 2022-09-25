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
          loadOffersEvent(event as HomepageLoadOffersEvent, emit);
          break;
        case HomepageRefreshEvent:
          refreshPage(event as HomepageRefreshEvent, emit);
          break;
        case HomepageSearchEvent:
          searchEvent(event as HomepageSearchEvent, emit);
          break;
        case HomepageLoadFavoriteEvent:
          loadFavorite(event as HomepageLoadFavoriteEvent, emit);
          break;
        case HomepageNavigateToDetailsEvent:
          navigationToDetailsEvent(
              event as HomepageNavigateToDetailsEvent, emit);
          break;
        case HomepageAddToFavoriteEvent:
          addToFavorite(event as HomepageAddToFavoriteEvent, emit);
          break;
        case HomepageRemoverFromFavoriteEvent:
          removeFromFavorite(event as HomepageRemoverFromFavoriteEvent, emit);
          break;
        default:
          emit(HomepageInitial());
          break;
      }
    });
  }

  void loadOffersEvent(
      HomepageLoadOffersEvent event, Emitter<HomepageState> emitter) async {
    emitter(HomepageLoadingOffersState());
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    res.fold((failure) => emitter(HomepageErrorState(failure)),
        (offers) => emitter(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emitter(HomepageInitial());
    });
  }

  void refreshPage(
      HomepageRefreshEvent event, Emitter<HomepageState> emitter) async {
    emitter(HomePageRefreshLoadingState());
    Either<Failure, List<OfferEntity>> res = await fetchAllOffersUseCase();
    res.fold((failure) => emitter(HomepageErrorState(failure)),
        (offers) => emitter(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emitter(HomepageInitial());
    });
  }

  void searchEvent(
      HomepageSearchEvent event, Emitter<HomepageState> emitter) async {
    Either<Failure, List<OfferEntity>> res = searchOffersUseCase(
        offers: event.oldOffers, searchKey: event.searchKey);
    res.fold((failure) => emitter(HomepageErrorState(failure)),
        (offers) => emitter(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emitter(HomepageInitial());
    });
  }

  void loadFavorite(
      HomepageLoadFavoriteEvent event, Emitter<HomepageState> emitter) async {
    Either<Failure, List<OfferEntity>> res = await loadFavoriteUseCases();
    res.fold((failure) => emitter(HomepageErrorState(failure)),
        (offers) => emitter(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emitter(HomepageInitial());
    });
  }

  void navigationToDetailsEvent(HomepageNavigateToDetailsEvent event,
      Emitter<HomepageState> emitter) async {
    navigateToDetailsUseCases(context: event.context, offer: event.offer);
  }

  void addToFavorite(
      HomepageAddToFavoriteEvent event, Emitter<HomepageState> emitter) async {
    Either<Failure, void> res = await addToFavoriteUseCase(offer: event.offer);
    res.fold((failure) => emitter(HomepageErrorState(failure)),
        (_) => emitter(HomepageAddToFavoriteDoneAnimationState()));
    await Future.delayed(const Duration(microseconds: 100), () {
      emitter(HomepageInitial());
    });
  }

  void removeFromFavorite(HomepageRemoverFromFavoriteEvent event,
      Emitter<HomepageState> emitter) async {
    final res = await removerFromFavoriteUseCases(
        offerId: event.offerId, offers: event.offers);
    res.fold((failure) => emitter(HomepageErrorState(failure)),
        (offers) => emitter(HomepageOffersLoadedState(offers)));
    await Future.delayed(const Duration(microseconds: 100), () {
      emitter(HomepageInitial());
    });
  }
}
