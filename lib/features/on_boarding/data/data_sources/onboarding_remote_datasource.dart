


import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/features/login/data/models/user_model.dart';

abstract class OnBoardingRemoteDataSource{

  ///we have email here so we try to get password and we have user here
  ///so login start depending on user data.
  ///If we field in getting password then the process will finish with exception.
  ///If any error happened it will throw [AutoLoginException]
  Future<UserCredential> loginUser({required UserModel userModel,required String password});
}