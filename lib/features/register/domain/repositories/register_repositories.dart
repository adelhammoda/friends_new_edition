

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';

import '../../../../core/failure/failure.dart';

abstract class RegisterRepositories{
  ///if there is no network [NetworkFailure] will be thrown.
  ///start with create user in database then, it will
  ///start register user by his email and password.
  ///if creating user in database failed then no registration
  ///operation will happened .We take all user data from [UserEntity]
  ///which passed as parameter.
  ///when creating user getting failed [CreateUserFailure] will
  ///be thrown.
  /// in case Firebase  errors [FirebaseFailure] will
  /// be thrown.
  /// otherwise , [UnKnownFailure] will be thrown.
  /// returns [UserCredential] in success case.
  Future<Either<Failure,UserCredential>> registerWithEmailAndPassword({required UserEntity user});
  ///if there is no network [NetworkFailure] will be thrown.
  ///start with getting user data from his email then, it will
  ///start register user by his email and password.
  ///if google account have user photo then it will be uploaded
  ///to firebase database (like another data : name, address ) ,
  ///user type will be student if authentication happen from mobile app.
  ///if creating user in database failed then no registration
  ///operation will happened .We take all user data from [UserEntity]
  ///which passed as parameter.
  ///when creating user getting failed [CreateUserFailure] will
  ///be thrown.
  /// in case Firebase  errors [FirebaseFailure] will
  /// be thrown.
  /// otherwise , [UnKnownFailure] will be thrown.
  /// returns [UserCredential] in success case.
  Future<Either<Failure,UserCredential>> registerWithGoogle();
  ///if there is no network [NetworkFailure] will be thrown.
  ///start with getting user data from his email then, it will
  ///start register user by his email and password.
  ///if google account have user photo then it will be uploaded
  ///to firebase database (like another data : name, address ) ,
  ///user type will be student if authentication happen from mobile app.
  ///if creating user in database failed then no registration
  ///operation will happened .We take all user data from [UserEntity]
  ///which passed as parameter.
  ///when creating user getting failed [CreateUserFailure] will
  ///be thrown.
  /// in case Firebase  errors [FirebaseFailure] will
  /// be thrown.
  /// otherwise , [UnKnownFailure] will be thrown.
  /// returns [UserCredential] in success case.
  Future<Either<Failure,UserCredential>> registerWithFacebook();
  ///if there is no network [NetworkFailure] will be thrown.
  ///start with getting user data from his email then, it will
  ///start register user by his email and password.
  ///if google account have user photo then it will be uploaded
  ///to firebase database (like another data : name, address ) ,
  ///user type will be student if authentication happen from mobile app.
  ///if creating user in database failed then no registration
  ///operation will happened .We take all user data from [UserEntity]
  ///which passed as parameter.
  ///when creating user getting failed [CreateUserFailure] will
  ///be thrown.
  /// in case Firebase  errors [FirebaseFailure] will
  /// be thrown.
  /// otherwise , [UnKnownFailure] will be thrown.
  /// returns [UserCredential] in success case.
  Future<Either<Failure,UserCredential>> registerWithApple();
  ///if there is no network [NetworkFailure] will be thrown.
  ///start creating user by taking his phone id to use it as user id.
  ///then we push all data that token form fields in UI or from
  ///provider authenticator into database.
  ///the type will be student if registration happened from mobile app.
  ///user profile photo can be null and it will replaced with place holder image.
  /// in case Firebase  errors [FirebaseFailure] will
  /// be thrown.
  /// otherwise , [UnKnownFailure] will be thrown.
  /// returns [UserCredential] in success case.
  Future<Either<Failure,void>> createUser({required UserEntity user});
  ///navigate to login page.
  ///in case failure it will throw [NavigateFailure].
  Either<Failure,void> alreadyHaveAccountNavigator(BuildContext context);
}