import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/register/domain/repositories/register_repositories.dart';

import '../../../../core/failure/failure.dart';

class AlreadyHaveAccountUseCase {
  final RegisterRepositories repo;

  AlreadyHaveAccountUseCase({required this.repo});

  Either<Failure, void> call(BuildContext context)  =>
       repo.alreadyHaveAccountNavigator(context);
}