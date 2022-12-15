import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/navigation/navigator.dart';
import 'package:friends/core/routes/routes.dart';

abstract class SettingRemoteDataSource {
  Future<void> logout({required String userId, required BuildContext context});

  Future<void> deleteAccount(
      {required String userId, required BuildContext context});
}

class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  @override
  Future<void> deleteAccount(
      {required String userId, required BuildContext context}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw UserNotFoundException(
          message: StringManager.userIsNotAuthenticated);
    } else {
      await currentUser.delete();
      await FirebaseDatabase.instance
          .ref(ConstantManager.usersRef)
          .child(userId)
          .remove().then((value) => Go.to(context, Routes.homePage));
    }
  }

  @override
  Future<void> logout({required String userId, required BuildContext context}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw UserNotFoundException(
          message: StringManager.userIsNotAuthenticated);
    } else {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => Go.to(context, Routes.homePage));
    }
  }
}
