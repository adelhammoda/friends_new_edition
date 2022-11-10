import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/device_info/device_info.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/navigation/navigator.dart';
import 'package:friends/core/routes/routes.dart';
import 'package:friends/features/QRGenerator/data/data_sources/qr_generator_local_data_source.dart';
import 'package:friends/features/QRGenerator/domain/repositories/qr_generator_repository.dart';
import 'package:friends/features/home_page/presentation/manager/homepage_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrGeneratorRepositoryImpl implements QRGeneratorRepository {
  final QrGeneratorLocalDataSource local;
  final DeviceInfo deviceInfo;

  QrGeneratorRepositoryImpl({required this.local, required this.deviceInfo,});

  @override
  Future<Either<Failure, QrImage>> generateQrCode(
      {required HomepageBloc homeBlocProvider, required BuildContext context}) async {
    try {
      final user = await homeBlocProvider.getCurrentUserUseCases();
      return user.fold((failure) {
        Go.to(context, Routes.register);
        return left(failure);
      }, (user) async {
        if (user.user == ConstantManager.studentType) {
          final phoneId = await deviceInfo.getDeviceId();
          return Right(local.generateQrCode(data: phoneId));
        } else {
          throw ThisUserIsNotStudentException();
        }
      });
    } on DeviceInfoException catch (e) {
      debugPrint(e.message);
      return const Left(DeviceInfoFailure());
    } on ThisUserIsNotStudentException catch (e) {
      debugPrint(e.message);
      return const Left(ThisUserIsNotStudentFailure());
    } catch (e) {
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }
}