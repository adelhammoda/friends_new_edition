import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';

import '../../../login/data/models/user_model.dart' as login;

class UserModel extends login.UserModel {
  UserModel(
      {required super.name,
      required super.email,
      required super.user,
      required super.address,
      required super.imageUrl,
      required super.subscribeId});

  factory UserModel.fromUserCredential(
      {required UserCredential userCredential}) {
    User? user = userCredential.user;
    if (user == null||user.email == null) {
      throw CreateUserException(
        message: StringManager.createErrorDataMissing,
      );
    }
    return UserModel(
        name: user.displayName ?? "name",
        email: user.email!,
        user: ConstantManager.studentType,
        address: {},
        imageUrl: user.photoURL,
        subscribeId: "");
  }
}
