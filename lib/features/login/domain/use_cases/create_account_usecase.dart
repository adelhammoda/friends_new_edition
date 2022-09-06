import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/failure/failure.dart';

class CreateAccountUseCases {
  final LoginRepositories repositories;

  CreateAccountUseCases(this.repositories);

  Either<Failure, void> call({
    required BuildContext context,
    required String email,
    required String password,
  }) =>
      repositories.createAccount(
          context: context, email: email, password: password);
}
