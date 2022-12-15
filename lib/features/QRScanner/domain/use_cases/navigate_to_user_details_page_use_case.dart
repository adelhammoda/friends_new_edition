import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/repositories/qr_scanner_repository.dart';

class NavigateToUserDetailsPageUseCase {
  final QrScannerRepository repository;

  NavigateToUserDetailsPageUseCase(this.repository);

  Either<Failure, void> call({required BuildContext context,required String userId}) =>
      repository.navigateToUserDetailsPage(context: context,userId:userId);
}
