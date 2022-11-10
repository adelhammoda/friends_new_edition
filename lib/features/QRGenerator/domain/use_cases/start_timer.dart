


import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRGenerator/domain/repositories/qr_generator_repository.dart';

class StartTimerUseCase{
  final QRGeneratorRepository repository;

  StartTimerUseCase(this.repository);

  Either<Failure,Timer> call(Function() hideQr)=>repository.startTimer(hideQr);
}