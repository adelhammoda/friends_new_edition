import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';
import 'package:friends/features/register/domain/repositories/register_repositories.dart';

import '../../../../core/failure/failure.dart';

class RegisterWithEmailAndPasswordUseCase {
  final RegisterRepositories repo;

  RegisterWithEmailAndPasswordUseCase({required this.repo});

  Future<Either<Failure, UserCredential>> call(BuildContext context,{required UserEntity user,required String password}) async =>
      await repo.registerWithEmailAndPassword(context,user: user,password: password);
}