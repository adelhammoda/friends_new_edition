

import 'dart:convert';

import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:friends/features/login/data/models/user_model.dart';

abstract class OnBoardingLocalDataSource {
  ///override getCashedUser method from parent class
  ///this method get user from local storage using [SharedPreferences]
  Future<UserModel> getCashedUser();
  ///check if user is exists in local storage.
  ///In false case we will try to get user email and password.
  ///then we will search user in database if every thing is ok , then
  ///login will happened automatically.
  ///if email and password is not exist then , the user must login again.
  Future<bool> isUserExists();
  ///get email and password storing in local storage
  ///and convert them into map.
  Future<Map<String,String>> getUserEmailAndPassword();
}


class OnBoardingLocalDataSourceImpl extends OnBoardingLocalDataSource{
  @override
  Future<UserModel> getCashedUser() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? cashedUserString = sharedPreferences.getString(ConstantManager.cashedUser);
    if(cashedUserString.isNullOrEmpty()){
      throw UserNotFoundException();
    }else {
      var cashedUserJson = jsonDecode(cashedUserString!);
      if(cashedUserString is Map){
        return UserModel.fromJson(cashedUserJson);
      }else{
        throw CashException();
      }
    }
  }

  @override
  Future<Map<String, String>> getUserEmailAndPassword() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? emailAndPasswordString = sharedPreferences.getString(ConstantManager.cashedEmailAndPasswordKey);
    if(!emailAndPasswordString.isNullOrEmpty()){
      throw UserNotFoundException();
    }else{
      var emailAndPasswordJson = jsonDecode(emailAndPasswordString!);
      //is map condition used in this page only.
      if(emailAndPasswordJson is Map){
        return emailAndPasswordJson as Map<String,String>;
      }else{
        throw CashException();
      }
    }
  }

  @override
  Future<bool> isUserExists() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? cashedData = sharedPreferences.getString(ConstantManager.usersRef);
    if(cashedData.isNullOrEmpty()){
      return false;
    }else{
      return true;
    }
  }

}
