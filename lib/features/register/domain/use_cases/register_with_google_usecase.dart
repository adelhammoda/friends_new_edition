


import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/features/register/domain/repositories/register_repositories.dart';

import '../../../../core/failure/failure.dart';

class RegisterWithGoogleUseCase{
  final RegisterRepositories repo;

  RegisterWithGoogleUseCase({required this.repo});


  Future<Either<Failure,UserCredential>> call()async => await repo.registerWithGoogle();


}