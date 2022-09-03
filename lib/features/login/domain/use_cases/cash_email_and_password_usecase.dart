import 'package:dartz/dartz.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/exception/failure.dart';

class CashEmailAndPassword {
  final LoginRepositories repositories;

  CashEmailAndPassword(this.repositories);

  Future<Either<Failure, Null>> call({
    required String email,
    required String password,
  }) async =>
      await repositories.cashEmailAndPassword(email: email, password: password);
}
