


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


class SubscriptionLocalDataSourceImpl implements SubscriptionLocalDataSource {


  @override
  Future<List<SubscriptionEntity>> getCashedSubscriptions() async {
    if(Hive.isBoxOpen(ConstantManager.hiveBoxNameForSubscription)) {
      final Box<String> hiveBox = Hive.box(
          ConstantManager.hiveBoxNameForSubscription);
      List<String> stringList = hiveBox.values.toList();
      List<Map> jsonList = stringList.map((string) => jsonDecode(string) as Map)
          .toList();
      List<SubscriptionEntity> subscriptionList = jsonList.map((json) =>
          SubscriptionModel.fromJson(json)).toList();
      return subscriptionList;
    }else{
      final Box<String> hiveBox =await Hive.openBox(ConstantManager.hiveBoxNameForSubscription);
      hiveBox.clear();
      List<String> stringList = hiveBox.values.toList();
      List<Map> jsonList = stringList.map((string) => jsonDecode(string) as Map)
          .toList();
      List<SubscriptionEntity> subscriptionList = jsonList.map((json) =>
          SubscriptionModel.fromJson(json)).toList();
      return subscriptionList;
    }
  }

  @override
  Future<void> cashSubscriptions(
      {required List<SubscriptionEntity> subscriptions}) async {
    if(!Hive.isBoxOpen(ConstantManager.hiveBoxNameForSubscription)){
      final Box<String> hiveBox=await Hive.openBox<String>(ConstantManager.hiveBoxNameForSubscription);
      final setOfSubscription = await getCashedSubscriptions();
      for(SubscriptionEntity cashed in setOfSubscription){
        for(SubscriptionEntity remote in subscriptions){
          if(remote.id==cashed.id){
            await hiveBox.add(jsonEncode((remote as SubscriptionModel).toJson()));
          }
        }
      }
    }else{
      final Box<String> hiveBox =  Hive.box<String>(ConstantManager.hiveBoxNameForSubscription);
      await hiveBox.addAll(subscriptions.map((e) =>
          jsonEncode((e as SubscriptionModel).toJson())));
      Hive.close();
    }


  }
}
