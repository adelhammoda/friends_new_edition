import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:friends/features/subscription/domain/repositories/subscription_repostiory.dart';

class GetPackagesFromCashUseCases {
  final SubscriptionRepository repository;

  GetPackagesFromCashUseCases({required this.repository});

  Future<Either<Failure, List<SubscriptionEntity>>> call() async =>
      await repository.getPackagesFromCash();
}
