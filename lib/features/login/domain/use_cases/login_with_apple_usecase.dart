




import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/failure/failure.dart';

class LoginWithAppleUseCases{



  final LoginRepositories repositories;

  LoginWithAppleUseCases(this.repositories);

  Future<Either<Failure,UserCredential>> call()async=>await repositories.loginWithApple();

}