




import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

class LoginWithFacebookUseCases{
  final LoginRepositories repositories;

  LoginWithFacebookUseCases(this.repositories);

  Future<Either<Failure,UserCredential>> call()async=>await repositories.loginWithFacebook();




}