






import 'package:dartz/dartz.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/exception/failure.dart';

class CreateAccount{

  final LoginRepositories repositories;

  CreateAccount(this.repositories);


  Either<Failure,Null> call({
  required String email,
    required String password,
})=>repositories.createAccount(email: email, password: password);


}