

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/domain/repositories/home_page_repository.dart';

class NavigateToDetailsUseCases{
  final HomePageRepository repository;
  const NavigateToDetailsUseCases(this.repository);

  Either<Failure,void> call({required BuildContext context,
  required OfferEntity offer})=>repository.navigateToDetailsPage(context:context, offer: offer);



}