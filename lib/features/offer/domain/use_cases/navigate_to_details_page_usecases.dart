import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/features/offer/domain/repositories/home_page_repository.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';

class NavigateToDetailsUseCases {
  final OfferPageRepository repository;

  const NavigateToDetailsUseCases(this.repository);

  Either<Failure, void> call(
          {required BuildContext context,
          required OfferEntity offer,
          required OfferpageBloc bloc}) =>
      repository.navigateToDetailsPage(
          context: context, offer: offer, bloc: bloc);
}
