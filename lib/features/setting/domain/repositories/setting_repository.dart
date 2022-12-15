import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';

abstract class SettingRepository{
  Future<Either<Failure,void>> logout({required String userId,required BuildContext context});
  Future<Either<Failure,void>> deleteAccount({required String userId,required BuildContext context});
  Future<Either<Failure,void>> switchTheme({required bool dark});
  Future<Either<Failure,void>> switchLanguage({required String local});
}