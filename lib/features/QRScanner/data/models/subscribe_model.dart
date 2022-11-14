import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';

class SubscribeModel extends SubscribeEntity {
  SubscribeModel(
      {required super.id,
      required super.userId,
      required super.subscriptionTypeId,
      required super.date,
      required super.centerId});

  factory SubscribeModel.fromJson(Map json) {
    return SubscribeModel(
        id: json[ConstantManager.subscribeId],
        userId: json[ConstantManager.subscribeUserId],
        subscriptionTypeId: json[ConstantManager.subscribeSubscriptionTypeID],
        date: json[ConstantManager.subscribeDate].toString().toDateTime(),
        centerId: json[ConstantManager.subscribeCenterId]);
  }

  Map<String,dynamic> toJson(){
    return {
      ConstantManager.subscribeCenterId:centerId,
      ConstantManager.subscribeDate:date.toIso8601String(),
      ConstantManager.subscribeSubscriptionTypeID:subscriptionTypeId,
      ConstantManager.subscribeUserId:userId,
    };
  }
}
