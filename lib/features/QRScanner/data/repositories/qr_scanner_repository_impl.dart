import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/features/QRScanner/data/data_sources/qr_scanner_remote_data_source.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';
import 'package:friends/features/QRScanner/domain/repositories/qr_scanner_repository.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

class QrScannerRepositoryImpl extends QrScannerRepository {
  final QrScannerRemoteDataSource remote;
  final NetworkInfo networkInfo;

  QrScannerRepositoryImpl({
    required this.remote,
    required this.networkInfo,
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
}
