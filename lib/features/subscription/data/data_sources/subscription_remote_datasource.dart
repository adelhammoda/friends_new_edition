


import 'package:firebase_database/firebase_database.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/subscription/data/models/subscription_model.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

abstract class SubscriptionRemoteDataSource {
  ///fetch all packages from database.
  Future<List<SubscriptionEntity>> fetchAllSubscriptions();


}


class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource{
  @override
  Future<List<SubscriptionEntity>> fetchAllSubscriptions() async{
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref(ConstantManager.subscriptionRef).get();
    var data = snapshot.value;
    if(data is Map){
      List<SubscriptionEntity> res = [];
      data.forEach((id, value) {
        Map json = value as Map;
        json.addAll({ConstantManager.subscriptionID:id});
        res.add(SubscriptionModel.fromJson(json));
      });
      return res;
    }else if(data == null ){
      throw NoDataException();
    }else {
      throw FetchSubscriptionException();
    }
  }
}