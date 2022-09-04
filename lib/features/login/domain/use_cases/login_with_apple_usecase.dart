




import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/failure/failure.dart';

class LoginWithApple{



  final LoginRepositories repositories;

  LoginWithApple(this.repositories);

  Future<Either<Failure,UserCredential>> call()async=>await repositories.loginWithApple();

}