import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';
import 'package:friends/features/QRScanner/domain/repositories/qr_scanner_repository.dart';

class GetUserSubscribesUseCase {
  final QrScannerRepository repository;

  GetUserSubscribesUseCase(this.repository);

  Future<Either<Failure, List<SubscribeEntity>>> call(
          {required String userId}) async =>
      await repository.getUserSubscribes(userId: userId);
}
