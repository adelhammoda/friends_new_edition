


import 'dart:convert';

import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/data/models/user_model.dart';

abstract class RegisterLocalDataSource{
  ///cash user after he register successfully in local storage
  ///using [SharedPreferences] package.
  ///if any cash error happened [CashException] error will
  ///thrown.
  ///keys and other benefits is token from [ConstantManager].
  Future<void> cashUser({required UserModel user});
  ///get cashed user from [SharedPreferences] package in local storage
  ///this will return user cashed from database.
  ///if there is no user in local database it will throw[CashException].
  Future<UserModel> getCashedUser();
}

class RegisterLocalDataSourceImpl extends RegisterLocalDataSource{

  @override
  Future<void> cashUser({required UserModel user}) async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String cashedString = jsonEncode(user.toJson());
    sharedPreferences.setString(ConstantManager.cashedUser, cashedString);
  }

  @override
  Future<UserModel> getCashedUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? cashedString = sharedPreferences.getString(ConstantManager.cashedUser);
    if(cashedString == null){
      throw CashException(
        message: StringManager.fetchCashedUserErrorMessage,
      );
    }
    var json = jsonDecode(cashedString);
    if(json is Map) {
      return UserModel.fromJson(json);
    }else{
      throw CashException(
        message: StringManager.fetchCashedUserErrorMessage
      );
    }
  }
}