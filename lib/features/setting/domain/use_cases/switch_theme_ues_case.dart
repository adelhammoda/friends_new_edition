import 'package:dartz/dartz.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/setting/domain/repositories/setting_repository.dart';

class SwitchThemeUseCase{

  final SettingRepository repository;

  SwitchThemeUseCase(this.repository);

  Future<Either<Failure,void>> call({required bool isDark})=>repository.switchTheme(dark: isDark);

}