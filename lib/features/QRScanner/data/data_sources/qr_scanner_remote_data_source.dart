import 'package:firebase_database/firebase_database.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/QRScanner/data/models/subscribe_model.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';
import 'package:friends/features/login/data/models/user_model.dart';
import 'package:friends/features/subscription/data/models/subscription_model.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

abstract class QrScannerRemoteDataSource {
  ///get all subscriptions packages info
  Future<List<SubscriptionEntity>> getSubscriptionsInfo(
      {required List<String> packagesId});

  ///get subscription center info that scanned the package.
  Future<UserEntity> getCenterInfo({required String centerId});

  ///get user info to know his name and another details.
  Future<UserEntity> getUserInfo({required String userId});

  ///get all user subscribes
  Future<List<SubscribeEntity>> getAllUserSubscribes({required String userId});
}

class QrScannerRemoteDataSourceImpl implements QrScannerRemoteDataSource {
  @override
  Future<List<SubscribeEntity>> getAllUserSubscribes(
      {required String userId}) async {
    DatabaseEvent event = await FirebaseDatabase.instance
        .ref(ConstantManager.subscribeRef)
        .orderByChild(ConstantManager.subscribeUserId)
        .equalTo(userId)
        .once();
    var value = event.snapshot.value;
    if (value is Map && value.isNotEmpty) {
      List<SubscribeEntity> res = [];
      value.forEach((id, value) {
        Map json = value as Map;
        json.addAll({ConstantManager.subscribeId: id});
        res.add(SubscribeModel.fromJson(json));
      });
      return res;
    } else {
      throw NoDataException();
    }
  }

  @override
  Future<UserEntity> getCenterInfo({required String centerId}) async {
    DatabaseEvent event = await FirebaseDatabase.instance
        .ref(ConstantManager.usersRef)
        .orderByChild(ConstantManager.userId)
        .once();
    var value = event.snapshot.value;
    if (value is Map && value.isNotEmpty && value.length > 1) {
      return UserModel.fromJson(value);
    } else {
      throw NoDataException();
    }
  }

  @override
  Future<List<SubscriptionEntity>> getSubscriptionsInfo(
      {required List<String> packagesId}) async {
    if (packagesId.isEmpty) {
      throw NoDataException();
    } else {
      List<SubscriptionEntity> res = [];
      for (String packageId in packagesId) {
        DataSnapshot snapshot = await FirebaseDatabase.instance
            .ref(ConstantManager.subscriptionRef)
            .child(packageId).get();
        var json = snapshot.value;
        if(json is Map){
          res.add(SubscriptionModel.fromJson(json));
        }else{
          throw NoDataException();
        }
      }
      res.sort((e1,e2)=>e1.endDate.compareTo(e2.endDate));
      return res;
    }
  }

  @override
  Future<UserEntity> getUserInfo({required String userId}) async {
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .ref(ConstantManager.usersRef)
        .child(userId).get();
    var json = snapshot.value;
    if(json is Map){
      return UserModel.fromJson(json);
    }else{
      throw NoDataException();
    }
  }
}
