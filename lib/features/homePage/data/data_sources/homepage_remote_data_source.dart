

import 'package:firebase_database/firebase_database.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/homePage/data/models/offer_model.dart';
import 'package:friends/features/login/data/models/user_model.dart';

import 'package:friends/core/exception/exception.dart';

abstract class HomePageRemoteDataSource{

  ///fetch all offers from database and convert them to list of offers.
  Future<List<OfferModel>> fetchOffers();
  ///get all offer info info from database.
  Future<UserModel>  fetchUser({required String userId});

}



class HomePageRemoteDataSourceImpl extends HomePageRemoteDataSource{
  @override
  Future<List<OfferModel>> fetchOffers() async{
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref(
        ConstantManager.offersRef).get();
    var data = snapshot.value;

    if (data != null && data is Map) {
      List<String> dataKeys = data.keys.map((e) => e.toString()).toList();
      List dataValue = data.values.toList();
      List<OfferModel> offers = [];
      for(int i = 0;i<dataValue.length;i++){
        String id = dataKeys[i];
        Map convertedJson=dataValue[i];
        convertedJson.addAll({ConstantManager.offerId:id});
        offers.add(OfferModel.fromJson(convertedJson));
      }
      return offers;
    } else if (data!= null && data is Map){
      List<OfferModel> result = [];
      String id = data.keys.first.toString();
      Map json = {ConstantManager.offerId:id};
      json.addAll(data[id]);
      result.add(OfferModel.fromJson(json));
      return result;
    }
    else {
      throw BadFormatException();
    }
  }

  @override
  Future<UserModel> fetchUser({required String userId}) async {
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref(
        ConstantManager.usersRef).child(userId).get();
    var data = snapshot.value;
    if (data != null && data is Map){
      Map json = { };
      data.forEach((key, value) {
        json = value as Map;
        json.addAll({ConstantManager.userId : key});
      });
      return UserModel.fromJson(json);
    }else{
      throw BadFormatException();
    }
  }
}





