






import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/failure/failure.dart';

class ForgetPassword{

  final LoginRepositories repositories;

  ForgetPassword(this.repositories);


  Either<Failure,void> call(BuildContext context)=>repositories.forgetPassword(context);


}