import 'package:friends/core/extension/color_extension.dart';
import 'package:friends/core/extension/map_extension.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';

class SubscriptionModel extends SubscriptionEntity {
  SubscriptionModel({required super.id,
    required super.name,
    required super.imageUrl,
    required super.borderColor,
    required super.endDate,
    required super.startDate,
    required super.backGroundColor,
    required super.currency,
    required super.price,
    super.description,});


  factory SubscriptionModel.fromJson(Map json){
    return SubscriptionModel(
        id: json[ConstantManager.subscriptionID],
        name: json[ConstantManager.subscriptionName],
        imageUrl: json[ConstantManager.subscriptionImageUrl],
        borderColor: (json[ConstantManager.subscriptionBorderColor] as Map).toColor(),
        endDate: json[ConstantManager.subscriptionEndDate].toString().toDateTime(),
        startDate: json[ConstantManager.subscriptionStartDate].toString().toDateTime(),
        backGroundColor: (json[ConstantManager.subscriptionBackGroundColor] as Map).toColor(),
        currency: json[ConstantManager.subscriptionCurrency],
        price: json[ConstantManager.subscriptionPrice].toString().toDouble(),
    description: json[ConstantManager.subscriptionDescription]);
  }

  Map<String , dynamic> toJson(){
    return {
      ConstantManager.subscriptionID:id,
      ConstantManager.subscriptionName:name,
      ConstantManager.subscriptionImageUrl:imageUrl,
      ConstantManager.subscriptionBorderColor:borderColor.toMap(),
      ConstantManager.subscriptionEndDate:endDate.toIso8601String(),
      ConstantManager.subscriptionStartDate:startDate.toIso8601String(),
      ConstantManager.subscriptionBackGroundColor:backGroundColor.toMap(),
      ConstantManager.subscriptionCurrency:currency,
      ConstantManager.subscriptionPrice:price,
      ConstantManager.subscriptionDescription:description,
    };
  }

}
