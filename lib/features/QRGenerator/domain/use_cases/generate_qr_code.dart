import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRGenerator/domain/repositories/qr_generator_repository.dart';
import 'package:friends/features/home_page/presentation/manager/homepage_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCodeUseCase {
  final QRGeneratorRepository repository;

  GenerateQRCodeUseCase(this.repository);

  Future<Either<Failure,QrImage>> call({required HomepageBloc homeBlocProvider,required BuildContext context})async =>await
      repository.generateQrCode(homeBlocProvider: homeBlocProvider,context: context);
}
