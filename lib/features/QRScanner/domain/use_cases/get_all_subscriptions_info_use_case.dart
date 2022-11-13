import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/repositories/qr_scanner_repository.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

class GetAllSubscriptionsInfoUseCase {
  final QrScannerRepository repository;

  GetAllSubscriptionsInfoUseCase(this.repository);

  Future<Either<Failure, List<SubscriptionEntity>>> call(
          {required List<String> subscriptionsPackagesId}) async =>
      await repository.getAllSubscriptionsInfo(
          subscriptionsPackagesId: subscriptionsPackagesId);
}
