import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/data/models/user_model.dart';

abstract class OnBoardingRemoteDataSource {
  ///we have email here so we try to get password and we have user here
  ///so login start depending on user data.
  ///If we field in getting password then the process will finish with exception.
  ///If any error happened it will throw [AutoLoginException]
  Future<UserCredential> loginUser(
      {required UserModel userModel,
      required String password,
      required String userDeviceId});
}

class OnBoardingRemoteDataSourceImpl extends OnBoardingRemoteDataSource {
  @override
  Future<UserCredential> loginUser(
      {required UserModel userModel,
      required String password,
      required String userDeviceId}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userModel.email, password: password);
      if (userCredential.user == null) {
        throw AutoLoginException(message: StringManager.userIsNotAuthenticated);
      }
      DataSnapshot snapshot = await FirebaseDatabase.instance
          .ref(ConstantManager.userRef)
          .child(userDeviceId)
          .get();
      if (snapshot.value == null) {
        throw AutoLoginException(
            message: StringManager.userNotFoundErrorMessage);
      } else {
        return userCredential;
      }
    } else {
      //TODO:navigate to home page using stream.
      throw UnimplementedError();
    }
  }
}
