


import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_models.dart';

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