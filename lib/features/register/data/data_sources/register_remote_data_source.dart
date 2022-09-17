import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';

import '../models/user_model.dart';

abstract class RegisterRemoteDataSource {
  ///take user email and password from UI and
  ///create new user in firebase authentication
  ///if any firebase exception happened then [FirebaseException]
  ///will thrown. otherwise ,[Exception] will thrown.
  ///then , crateUser methode will continue create user in database.
  Future<UserCredential> registerWithEmailAndPassword(
      {required String email, required String password});

  ///Register with auth provider from firebase package then
  ///create new user in firebase authentication
  ///if any firebase exception happened then [FirebaseException]
  ///will thrown. otherwise ,[Exception] will thrown.
  ///then , crateUser methode will continue create user in database.
  Future<UserCredential> registerWithGoogle();

  ///Register with auth provider from firebase package then
  ///create new user in firebase authentication
  ///if any firebase exception happened then [FirebaseException]
  ///will thrown. otherwise ,[Exception] will thrown.
  ///then , crateUser methode will continue create user in database.
  Future<UserCredential> registerWithFacebook();

  ///Register with auth provider from firebase package then
  ///create new user in firebase authentication
  ///if any firebase exception happened then [FirebaseException]
  ///will thrown. otherwise ,[Exception] will thrown.
  ///then , crateUser methode will continue create user in database.
  Future<UserCredential> registerWithApple();

  ///create user in firebase database after fetching his
  ///phone id and use it as id for firebase
  ///if any error happened [CreateUserException] will thrown.
  Future<void> createUser(
      {required UserModel user, required String userPhoneId});
}

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> createUser(
      {required UserModel user, required String userPhoneId}) async {
    Map<String, dynamic> data = {userPhoneId: user.toJson()};
    await firebaseDatabase.ref(ConstantManager.userRef).set(data);
  }

  @override
  Future<UserCredential> registerWithApple() async => await firebaseAuth.signInWithAuthProvider(AppleAuthProvider());

  @override
  Future<UserCredential> registerWithEmailAndPassword(
      {required String email, required String password})async=>await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential> registerWithFacebook() async=> await firebaseAuth.signInWithAuthProvider(FacebookAuthProvider());

  @override
  Future<UserCredential> registerWithGoogle()async=> await firebaseAuth.signInWithAuthProvider(GoogleAuthProvider());
}
