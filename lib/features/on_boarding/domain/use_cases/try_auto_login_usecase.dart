



import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/on_boarding/domain/repositories/on_boarding_repository.dart';

class TryAutoLoginUseCase{
  final OnBoardingRepository repository;

  TryAutoLoginUseCase(this.repository);
  Future<Either<Failure,UserCredential>> call() async=>await repository.tryAutoLogin();
}