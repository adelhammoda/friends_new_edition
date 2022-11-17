import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/repositories/qr_scanner_repository.dart';

class CloseCameraUseCase {
  final QrScannerRepository repository;

  CloseCameraUseCase(this.repository);

  Future<Either<Failure, void>> call() async =>
      await repository.closeCamera();
}
