




import 'package:dartz/dartz.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';
import 'package:friends/features/register/domain/repositories/register_repositories.dart';

import '../../../../core/failure/failure.dart';

class CreateUser{
  final RegisterRepositories repo;
 const CreateUser({required this.repo});

 Future<Either<Failure,void>> call({required UserEntity user})async=> await repo.createUser(user:user);
}