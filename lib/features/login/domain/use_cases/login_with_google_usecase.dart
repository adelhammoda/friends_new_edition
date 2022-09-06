






import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/login_repositories.dart';

import '../../../../core/failure/failure.dart';

class LoginWithGoogleUseCases{
  final LoginRepositories repositories;

  LoginWithGoogleUseCases(this.repositories);

  Future<Either<Failure,UserCredential>> call()async => await repositories.loginWithGoogle();



}