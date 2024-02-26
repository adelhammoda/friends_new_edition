import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/register/domain/repositories/register_repositories.dart';

import '../../../../core/failure/failure.dart';

class RegisterWithFacebookUseCase {
  final RegisterRepositories repo;

  RegisterWithFacebookUseCase({required this.repo});

  Future<Either<Failure, UserCredential>> call(BuildContext context) async =>
      await repo.registerWithFacebook( context);
}
