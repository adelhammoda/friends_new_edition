






import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/failure/failure.dart';

class ForgetPasswordUseCases{

  final LoginRepositories repositories;

  ForgetPasswordUseCases(this.repositories);


  Either<Failure,void> call(BuildContext context)=>repositories.forgetPassword(context);


}