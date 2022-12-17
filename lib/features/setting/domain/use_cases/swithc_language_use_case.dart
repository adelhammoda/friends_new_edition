import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/setting/domain/repositories/setting_repository.dart';

class SwitchLanguageUseCase{

  final SettingRepository repository;

  SwitchLanguageUseCase(this.repository);

  Future<Either<Failure,void>> call({required String local})=>repository.switchLanguage(local: local);

}