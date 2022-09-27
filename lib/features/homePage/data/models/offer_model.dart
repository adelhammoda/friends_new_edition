import 'package:friends/core/extension/list_extension.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';

class OfferModel extends OfferEntity {
  OfferModel(
      {required super.id,
      required super.name,
      required super.startDate,
      required super.endDate,
      required super.description,
      required super.discount,
      required super.info,
      required super.offerOwnerId,
      required super.totalCapacity,
      required super.value,
      required super.imagesUrl});

  factory OfferModel.fromJson(Map data) {
    var info = data[ConstantManager.offerInfo];
    List<Map>? infoM ;
    if(info is List){
      infoM = info.convertToListOfMap();
    }
    var images = data[ConstantManager.offerImages];
    List<String> imagesL=[] ;
    if(images is List){
      imagesL = images.toListOfString();
    }
    return OfferModel(
        id: data[ConstantManager.offerId],
        name: data[ConstantManager.offerName],
        startDate: data[ConstantManager.offerStartDate].toString().toDateTime(),
        endDate: data[ConstantManager.offerEndDate].toString().toDateTime(),
        description: data[ConstantManager.offerDescription],
        discount: data[ConstantManager.offerDiscount].toString().toDouble(),
        info:infoM,
        offerOwnerId: data[ConstantManager.offerOwnerId],
        totalCapacity: data[ConstantManager.offerTotalCapacity].toString().toInt(canBeNull: true),
        value: data[ConstantManager.offerValue].toString().toDouble(),
        imagesUrl:imagesL);
  }

  Map<String,dynamic> toJson(){
    return {
      ConstantManager.offerName:name,
      ConstantManager.offerImages:imagesUrl,
      ConstantManager.offerValue:value,
      ConstantManager.offerTotalCapacity:totalCapacity,
      ConstantManager.offerOwnerId:offerOwnerId,
      ConstantManager.offerStartDate:startDate.toIso8601String(),
      ConstantManager.offerEndDate:endDate.toIso8601String(),
      ConstantManager.offerDiscount:discount,
      ConstantManager.offerDescription:description,
      ConstantManager.offerInfo:info,
    };
  }
}



