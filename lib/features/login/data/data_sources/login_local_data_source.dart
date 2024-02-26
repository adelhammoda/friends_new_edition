import 'dart:convert';

import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  ///this function cash user email and password
  ///after he login successfully .
  ///in case of error , it will throw [CashException].
  Future<void> cashUserEmailAndPassword({
    required String email,
    required String password,
  });

  ///this function return cashed email and password
  ///to auto login return[Map] contain user key and user email
  ///password key and password like:
  ///{'email' : email,'password':password}
  ///throw [CashException] when having any problem
  Future<Map<String, String>> getCashedEmailAndPassword();
  ///cash user in local storage
  Future<void> cashUser({required UserModel user});
}
///implement class [LoginLocalDataSource] to define methods
///content.
///this class is responsible of every local operation happened on
///device in login feature
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  ///using [SharedPreferences] to get local storage where it will
  ///be const {can't be deleted} and cashing the user email and password in it
  /// as [Map].
  /// the key of getString function that references to data is token from [ConstantManager]
  @override
  Future<void> cashUserEmailAndPassword(
      {required String email, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> cashedData = {
      "email": email,
      "password": password,
    };
    await sharedPreferences.setString(
        ConstantManager.cashedEmailAndPasswordKey, jsonEncode(cashedData));
  }
  ///getting cashed user from local storage and decoding it to [var]
  ///then we need to check  the variable type if it's map then it return map
  ///containing user data otherwise , it will throw [FormatException]
  @override
  Future<Map<String, String>> getCashedEmailAndPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? cashedData =
        sharedPreferences.getString(ConstantManager.cashedEmailAndPasswordKey);
    if (cashedData == null) {
      throw CashException(message: StringManager.fetchCashedUserErrorMessage);
    } else {
      var decodedData = jsonDecode(cashedData);
      if (decodedData is Map<String, String>) {
        return decodedData;
      } else {
        throw const FormatException(StringManager.decodedCashedDataMessage);
      }
    }
  }

  @override
  Future<void> cashUser({required UserModel user})async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String cashedString = jsonEncode(user.toJson());
    sharedPreferences.setString(ConstantManager.cashedUser, cashedString);
  }
}
