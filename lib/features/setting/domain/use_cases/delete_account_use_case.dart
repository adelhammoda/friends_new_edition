

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/setting/domain/repositories/setting_repository.dart';

class DeleteAccountUseCase{

  final SettingRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure,void>> call({required String userId,required BuildContext context})=>repository.deleteAccount(userId: userId,context: context);

}