import 'package:friends/core/exception/exception.dart';

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
  Future<Map<String,String>> getCashedEmailAndPassword();
}
