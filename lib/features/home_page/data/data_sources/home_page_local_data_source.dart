

import 'dart:convert';

import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomePageLocalDataSource {

//get the current user hide in the cash.
  Future<UserEntity> fetchUserFromCash();

}


class HomePageLocalDataSourceImpl extends HomePageLocalDataSource{
  @override
  Future<UserEntity> fetchUserFromCash()async {
    final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? userCashedString = sharedPreferences.getString(ConstantManager.cashedUser);
    if(userCashedString.isNullOrEmpty()){
      throw  UserNotFoundInLocalStorageException();
    }else{
      Map userCashedMap = jsonDecode(userCashedString!) as Map;
      UserEntity user = UserModel.fromJson(userCashedMap);
      return user;
    }

  }

}