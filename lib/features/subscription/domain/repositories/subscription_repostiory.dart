

import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

abstract class SubscriptionRepository{

  ///we need to fetch all subscriptions package.
  Future<Either<Failure,List<SubscriptionEntity>>> fetchAllPackages();

}