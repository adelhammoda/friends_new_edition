import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/permission_manager.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/features/QRScanner/data/data_sources/qr_scanner_local_data_source.dart';
import 'package:friends/features/QRScanner/data/data_sources/qr_scanner_remote_data_source.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';
import 'package:friends/features/QRScanner/domain/repositories/qr_scanner_repository.dart';
import 'package:friends/features/QRScanner/presentation/manager/subscription_manager/subscription_bloc.dart';
import 'package:friends/features/QRScanner/presentation/manager/user_details_manager/user_details_bloc.dart';
import 'package:friends/features/QRScanner/presentation/pages/user_details_page.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:friends/injection_container.dart' as dl;

class QrScannerRepositoryImpl extends QrScannerRepository {
  final QrScannerRemoteDataSource remote;
  final QrScannerLocalDataSource local;
  final NetworkInfo networkInfo;
  final PermissionManager permissionManager;

  QrScannerRepositoryImpl({
    required this.remote,
    required this.networkInfo,
    required this.local,
    required this.permissionManager,
  });

  Future<Either<Failure, T>> _get<T>(Future<T> Function() remote) async {
    try {
      T result = await remote();
      return Right(result);
    } on NoDataException catch (e) {
      debugPrint(e.message);
      return const Left(NoDataFailure());
    } on NetworkException catch (e) {
      debugPrint(e.message);
      return const Left(NetworkFailure());
    } catch (e) {
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> getAllSubscriptionsInfo(
      {required List<String> subscriptionsPackagesId}) async {
    return await _get<List<SubscriptionEntity>>(
        () => remote.getSubscriptionsInfo(packagesId: subscriptionsPackagesId));
  }

  @override
  Future<Either<Failure, UserEntity>> getSubscriptionCenterInfo(
      {required String centerId}) async {
    return await _get<UserEntity>(
        () => remote.getCenterInfo(centerId: centerId));
  }

  @override
  Future<Either<Failure, UserEntity>> getUserInfo(
      {required String userId}) async {
    return await _get<UserEntity>(() => remote.getUserInfo(userId: userId));
  }

  @override
  Future<Either<Failure, List<SubscribeEntity>>> getUserSubscribes(
          {required String userId}) async =>
      await _get<List<SubscribeEntity>>(
          () => remote.getAllUserSubscribes(userId: userId));

  @override
  Future<Either<Failure, void>> closeCamera() async {
    try {
      await local.closeCamera();
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> openCamera() async {
    try {
      await permissionManager.requestCameraPermission();
      local.openCamera();
      return const Right(null);
    } on PermissionDeniedException catch (e) {
      debugPrint(e.message);
      return Left(PermissionDeniedFailure(message: e.message));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Either<Failure, void> navigateToUserDetailsPage(
      {required BuildContext context,required String userId}) {
    try {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) => MultiBlocProvider(
              providers: [
                BlocProvider<SubscriptionQrScannerBloc>(create: (c)=>dl.sl<SubscriptionQrScannerBloc>()),
                BlocProvider<UserDetailsBloc>(create: (c)=>dl.sl<UserDetailsBloc>()),
              ], child:  UserDetailsPage(userId: userId,))));
      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return const Left(NavigationFailure());
    }
  }
}
