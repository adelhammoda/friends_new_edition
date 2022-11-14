


import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

abstract class QrScannerRemoteDataSource {
  ///get all subscriptions packages info
  Future<List<SubscriptionEntity>> getSubscriptionsInfo({required List<String> packagesId});
  ///get subscription center info that scanned the package.
  Future<UserEntity> getCenterInfo({required String centerId});
  ///get user info to know his name and another details.
  Future<UserEntity> getUserInfo({required String userId});
  ///get all user subscribes
  Future< List<SubscribeEntity>> getAllUserSubscribes({required String userId});
}