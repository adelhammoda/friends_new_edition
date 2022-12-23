import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/setting/domain/repositories/setting_repository.dart';

class LoadUserPreferencesUseCase{

  final SettingRepository repository;

  LoadUserPreferencesUseCase(this.repository);

  Future<Either<Failure,Map<String,dynamic>>> call()=>repository.loadUserPreferences();

}