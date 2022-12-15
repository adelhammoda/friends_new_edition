import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';

abstract class UserDetailsRepository{
  Future<Either<Failure,void>> logout({required String userId});
  Future<Either<Failure,void>> deleteAccount({required String userId});
  Future<Either<Failure,void>> switchTheme({required bool dark});
}