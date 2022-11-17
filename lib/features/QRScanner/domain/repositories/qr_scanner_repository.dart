

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

abstract class QrScannerRepository{
  ///get user info by scanning user id.
  Future<Either<Failure,UserEntity>> getUserInfo({required String userId});
  ///get all packages the user subscribe to.
  Future<Either<Failure,List<SubscribeEntity>>> getUserSubscribes({required String userId});
  ///get all data about center where use scanned in.
  Future<Either<Failure,UserEntity>> getSubscriptionCenterInfo({required String centerId});
  ///get all subscriptions packages details.
  Future<Either<Failure,List<SubscriptionEntity>>> getAllSubscriptionsInfo({required List<String> subscriptionsPackagesId});
  ///open camera.
  Future<Either<Failure,void>> openCamera();
  ///close camera.
  Future<Either<Failure,void>> closeCamera();
  ///navigate to user details page
  Either<Failure,void> navigateToUserDetailsPage({required BuildContext context,required String userId});
}