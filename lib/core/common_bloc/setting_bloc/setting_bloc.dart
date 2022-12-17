import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friends/features/setting/domain/use_cases/delete_account_use_case.dart';
import 'package:friends/features/setting/domain/use_cases/logout_use_case.dart';
import 'package:friends/features/setting/domain/use_cases/switch_theme_ues_case.dart';
import 'package:friends/features/setting/domain/use_cases/swithc_language_use_case.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SwitchThemeUseCase switchThemeUseCase;
  final SwitchLanguageUseCase switchLanguageUseCase;
  final LogoutUseCase logoutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  SettingBloc(
      {required this.switchThemeUseCase,
      required this.switchLanguageUseCase,
      required this.logoutUseCase,
      required this.deleteAccountUseCase,})
      : super(SettingInitial()) {
    on<SettingEvent>((event, emit) {
      if(event is RebuildTheAppEvent){
        print('rebuild the app ');
        emit(ReBuildTheAppState(state: event.event));
      }
    });
  }
}
