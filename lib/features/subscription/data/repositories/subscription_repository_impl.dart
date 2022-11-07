import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/features/subscription/data/data_sources/subscription_local_datasource.dart';
import 'package:friends/features/subscription/data/data_sources/subscription_remote_datasource.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:friends/features/subscription/domain/repositories/subscription_repostiory.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final SubscriptionRemoteDataSource remote;
  final SubscriptionLocalDataSource local;
  final NetworkInfo networkInfo;

  SubscriptionRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> fetchAllPackages() async {
    try {
      bool hasNetwork = await networkInfo.isConnected;
      if (hasNetwork) {
        List<SubscriptionEntity> packages =
            await remote.fetchAllSubscriptions();
        local.cashSubscriptions(subscriptions: packages);
        return Right(packages);
      } else {
        throw NetworkException();
      }
    } on NetworkException catch (e) {
      debugPrint(e.message);
      return Left(NetworkFailure(message: e.message));
    }on NoDataException catch(e){
      debugPrint(e.message);
      return const Left(NoDataFailure());
    }
    catch (e) {
      debugPrint(e.toString());
      return const Left(UnKnownFailure());
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionEntity>>>
      getPackagesFromCash() async {
    try {
      final list = await local.getCashedSubscriptions();
      return Right(list);
    } catch (e) {
      debugPrint(e.toString());
      return const Left(CashFailure());
    }
  }
}
