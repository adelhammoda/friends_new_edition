



import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_models.dart';


abstract class RegisterRemoteDataSource{
  ///take user email and password from UI and
  ///create new user in firebase authentication
  ///if any firebase exception happened then [FirebaseException]
  ///will thrown. otherwise ,[Exception] will thrown.
  ///then , crateUser methode will continue create user in database.
  Future<UserCredential> registerWithEmailAndPassword({required String email,required String password});
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
  Future<void> createUser({required UserModel user});

}