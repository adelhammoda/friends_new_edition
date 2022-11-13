import 'package:dartz/dartz.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/repositories/qr_scanner_repository.dart';

class GetSubscriptionCenterInfo {
  final QrScannerRepository repository;

  GetSubscriptionCenterInfo(this.repository);

  Future<Either<Failure, UserEntity>> call({required String centerId}) async =>
      await repository.getSubscriptionCenterInfo(centerId: centerId);
}
