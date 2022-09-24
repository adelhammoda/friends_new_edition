import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/homePage/data/models/offer_model.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:hive/hive.dart';

abstract class HomepageLocalDataSource {
  ///get all favorites from hive data base.
  Future<List<OfferModel>> getAllFavorite();

  ///add new offer to favorite in database.
  Future<bool> moveToFavorite({required OfferModel offer});

  ///search in favorite .
  List<OfferEntity> searchOffer({
    required List<OfferEntity> offers,
    required String searchKey,
  });
}

class HomePageLocalDataSourceImpl extends HomepageLocalDataSource {
  @override
  Future<List<OfferModel>> getAllFavorite()async {
    Box<Map> box = await Hive.openBox<Map>(
        ConstantManager.hiveBoxNameForOffer,
        collection: ConstantManager.hiveCollectionName);
    List<OfferModel> result = [];
    for(Map data in box.values){
      result.add(OfferModel.fromJson(data));
    }
    if(result.isNotEmpty) {
      return result;
    } else {
      throw NoDataException();
    }
  }

  @override
  Future<bool> moveToFavorite({required OfferModel offer}) async {
    Box<Map> box = await Hive.openBox<Map>(
        ConstantManager.hiveBoxNameForOffer,
        collection: ConstantManager.hiveCollectionName);
    box.put(offer.id, offer.toJson());
    await Hive.close();
    return true;
  }

  @override
  List<OfferEntity> searchOffer(
      {required List<OfferEntity> offers, required String searchKey}) {
    return offers.where((offer) => offer.name.toLowerCase().compareTo(searchKey)==0).toList();
  }
}
