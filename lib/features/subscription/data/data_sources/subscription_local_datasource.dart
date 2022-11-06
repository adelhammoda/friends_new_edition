


import 'dart:convert';

import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/subscription/data/models/subscription_model.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:hive/hive.dart';

abstract class SubscriptionLocalDataSource {
  ///to cash all subscriptions.
  Future<void> cashSubscriptions({required List<SubscriptionEntity> subscriptions});
  ///to get all subscriptions packages in offline mode.
  Future<List<SubscriptionEntity>> getCashedSubscriptions();
}


class SubscriptionLocalDataSourceImpl implements SubscriptionLocalDataSource{

  final Box<String> _hiveBox = Hive.box(ConstantManager.hiveBoxNameForSubscription);
  @override
  Future<List<SubscriptionEntity>> getCashedSubscriptions() async{
    List<String> stringList = _hiveBox.values.toList();
    List<Map> jsonList = stringList.map((string) => jsonDecode(string) as Map).toList();
    List<SubscriptionEntity> subscriptionList = jsonList.map((json) => SubscriptionModel.fromJson(json)).toList();
    return subscriptionList;
  }

  @override
  Future<void> cashSubscriptions({required List<SubscriptionEntity> subscriptions}) async{
    await _hiveBox.addAll(subscriptions.map((e) => jsonEncode((e as SubscriptionModel).toJson())));
  }
}