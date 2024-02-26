


import 'package:firebase_auth/firebase_auth.dart';


abstract class LoginRemoteDataSource{

  ///use email and password to create new user on firebase
  ///it uses firebase packages to complete authentication processes
  ///throw [FirebaseException] when firebase exception happen.
  ///throw [FormatException] when format exception happen.
  ///otherwise , it will [UnknownException] .
  Future<UserCredential> loginWithEmailAndPassword({required String email,required String password});
  ///use Google authenticator provider that firebase
  ///packages present it.
  ///throw [FirebaseException] when firebase exception happen.
  ///throw [FirebaseAuthException] in some status.
  ///otherwise , it will throw [Exception];
  Future<UserCredential> loginWithGoogle();
  ///use Google authenticator provider that firebase
  ///packages present it.
  ///throw [FirebaseException] when firebase exception happen.
  ///throw [FirebaseAuthException] in some status.
  ///otherwise , it will throw [Exception];
  Future<UserCredential> loginWithFacebook();
  ///use Google authenticator provider that firebase
  ///packages present it.
  ///throw [FirebaseException] when firebase exception happen.
  ///throw [FirebaseAuthException] in some status.
  ///otherwise , it will throw [Exception];
  Future<UserCredential> loginWithApple();
}



class LoginRemoteDataSourceImpl implements LoginRemoteDataSource{
  @override
  Future<UserCredential> loginWithApple() => FirebaseAuth.instance.signInWithAuthProvider(AppleAuthProvider());

  @override
  Future<UserCredential> loginWithEmailAndPassword({required String email,required String password}) =>FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential> loginWithFacebook() => FirebaseAuth.instance.signInWithAuthProvider(FacebookAuthProvider());

  @override
  Future<UserCredential> loginWithGoogle() =>FirebaseAuth.instance.signInWithAuthProvider(GoogleAuthProvider());



}