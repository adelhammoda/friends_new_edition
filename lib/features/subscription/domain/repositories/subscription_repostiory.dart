

import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

abstract class SubscriptionRepository{

  ///we need to fetch all subscriptions package.
  Future<Either<Failure,List<SubscriptionEntity>>> fetchAllPackages();
  ///to get all packages from cash in case no internet connection.
  Future<Either<Failure,List<SubscriptionEntity>>> getPackagesFromCash();

}