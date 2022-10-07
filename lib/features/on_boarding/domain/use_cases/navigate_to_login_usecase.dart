import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/on_boarding/domain/repositories/on_boarding_repository.dart';

class NavigateToLoginUseCase {
  final OnBoardingRepository repository;

  NavigateToLoginUseCase(this.repository);

  Either<Failure,void> call({required BuildContext context}) {
    return repository.navigateToLogin(context);
  }
}
