






import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/login_repositories.dart';

import '../../../../core/exception/failure.dart';

class LoginWithGoogle{
  final LoginRepositories repositories;

  LoginWithGoogle(this.repositories);

  Future<Either<Failure,UserCredential>> call()async => await repositories.loginWithGoogle();



}