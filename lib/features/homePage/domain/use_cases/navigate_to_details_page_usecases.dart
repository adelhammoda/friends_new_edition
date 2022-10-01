import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';
import 'package:friends/features/homePage/presentation/manager/homepage_offer_bloc.dart';

class NavigateToDetailsUseCases {
  final HomePageRepository repository;

  const NavigateToDetailsUseCases(this.repository);

  Either<Failure, void> call(
          {required BuildContext context,
          required OfferEntity offer,
          required HomepageBloc bloc}) =>
      repository.navigateToDetailsPage(
          context: context, offer: offer, bloc: bloc);
}
