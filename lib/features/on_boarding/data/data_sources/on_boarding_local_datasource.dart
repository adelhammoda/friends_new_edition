

import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/data/models/user_model.dart';

abstract class OnBoardingLocalDataSource {
  ///override getCashedUser method from parent class
  ///this method get user from local storage using [SharedPreferences]
  ///on any error happened it will throw [CashException].
  ///the user key is form [ConstantManager]
  Future<UserModel> getCashedUser();
  ///check if user is exists in local storage.
  ///In false case we will try to get user email and password.
  ///then we will search user in database if every thing is ok , then
  ///login will happened automatically.
  ///if email and password is not exist then , the user must login again.
  Future<void> isUserExists();
  ///get email and password storing in local storage
  ///and convert them into map.
  ///It will throw [CashException] in error case.
  Future<Map<String,String>> getUserEmailAndPassword();
}


//TODO:implementing OnBoardingLocalDataSource class
