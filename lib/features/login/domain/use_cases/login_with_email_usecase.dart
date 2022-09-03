




import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/core/exception/failure.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

class LoginWithEmailAndPassword{

  final LoginRepositories loginRepositories;

  LoginWithEmailAndPassword(this.loginRepositories);


  Future<Either<Failure,UserCredential>> call({
  required String email,
  required  String password,
})async => await loginRepositories.loginWithEmailAndPassword(email: email, password: password);




}