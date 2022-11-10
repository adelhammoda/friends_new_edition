import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/home_page/presentation/manager/homepage_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

abstract class QRGeneratorRepository {
  ///generate qr depending on user
  Future<Either<Failure, QrImage>> generateQrCode(
      {required HomepageBloc homeBlocProvider, required BuildContext context});
}