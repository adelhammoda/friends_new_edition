

import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:hive/hive.dart';

abstract class HomepageLocalDataSource {
  ///get all favorites from hive data base.
  Future<Set<String>> getAllFavorite();

  ///add new offer to favorite in database.
  Future<bool> moveToFavorite({required String offer});

  ///search in favorite .
  List<OfferEntity> searchOffer({
    required List<OfferEntity> offers,
    required String searchKey,
  });

  Future<void> removerFromFavorite({required String offerId}) ;
}

class HomePageLocalDataSourceImpl extends HomepageLocalDataSource {
  @override
  Future<Set<String>> getAllFavorite() async {
    Box<String> box = await Hive.openBox<String>(
        ConstantManager.hiveBoxNameForOffer,
        collection: ConstantManager.hiveCollectionName);
    Set<String> result = {};
    for (String data in box.values) {
      result.add(data);
    }
    if (result.isNotEmpty) {
      return result;
    } else {
      return {};
    }
  }

  @override
  Future<bool> moveToFavorite({required String offer}) async {
    Box<String> box = await Hive.openBox<String>(
        ConstantManager.hiveBoxNameForOffer,
        collection: ConstantManager.hiveCollectionName);
    box.put(offer, offer);
    return true;
  }

  @override
  List<OfferEntity> searchOffer(
      {required List<OfferEntity> offers, required String searchKey}) {
    return offers.where((offer) =>
    offer.name.toLowerCase().contains(searchKey.toLowerCase())).toList();
  }

  @override
  Future<void> removerFromFavorite({required String offerId}) async {

    final Box<String> box = await Hive.openBox<String>(
        ConstantManager.hiveBoxNameForOffer,
        collection: ConstantManager.hiveCollectionName
    );

    await box.delete(offerId);

    return ;
  }
}
