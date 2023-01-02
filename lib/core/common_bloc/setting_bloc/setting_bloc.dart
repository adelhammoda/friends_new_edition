import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/log/log.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/setting/domain/use_cases/delete_account_use_case.dart';
import 'package:friends/features/setting/domain/use_cases/load_user_preferences_use_case.dart';
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
  final LoadUserPreferencesUseCase loadUserPreferencesUseCase;

  SettingBloc({
    required this.switchThemeUseCase,
    required this.switchLanguageUseCase,
    required this.logoutUseCase,
    required this.deleteAccountUseCase,
    required this.loadUserPreferencesUseCase,
  }) : super(SettingInitial()) {
    on<SettingEvent>((event, emit) async {
      if (event is RebuildTheAppEvent) {
        if(event.isDark!=null) {
          Either<Failure, void> res =
          await switchThemeUseCase(isDark: event.isDark!);
          res.fold(
                  (failure) => PrintLog.call(
                  tag: "SwitchTheme",
                  message: "Error in bloc event while rebuilding the app",
                  error: failure.message),
                  (r) => null);
        }
        if(event.local!=null) {
          Either<Failure, void> localeRes = await switchLanguageUseCase(
              local: event.local!.languageCode);
          localeRes.fold(
                  (failure) => PrintLog.call(
                  tag: "Switch language to ${event.local?.toLanguageTag()}",
                  message: "Error in bloc event while rebuilding the app",
                  error: failure.message),
                  (r) => null);
        }

        emit(ReBuildTheAppState(state: event.event,locale: event.local));
      } else if (event is DeleteAccountEvent) {
        emit(const LoadingState());
        if (event.userEmail == null) {
          emit(const ErrorState(
              failure: StringManager.userIsNotAuthenticated,
              failureType: FailureType.warning));
        }else {
          final res = await deleteAccountUseCase(
              context: event.context, userId: event.userEmail!);
          res.fold(
                  (failure) =>
                  emit(ErrorState(
                      failure: failure.message,
                      failureType: FailureType.error)),
                  (r) =>
                  emit(const SuccessState(
                      message: StringManager.theUserDeletedSuccessfully)));
        }
      } else if (event is LoadUserPreferencesEvent) {
        final res = await loadUserPreferencesUseCase();
        res.fold(
            (l) => null,
            (data) => emit(UserEventState(
                theme: data[ConstantManager.theme],
                local: data[ConstantManager.local])));
      } else if (event is LogoutEvent) {
        emit(const LoadingState());
        if (event.userEmail == null) {
          emit(const ErrorState(
              failure: StringManager.userIsNotAuthenticated,
              failureType: FailureType.warning));
        }else {
          final res = await logoutUseCase(
              userId: event.userEmail!, context: event.context);
          res.fold(
                  (failure) =>
                  emit(ErrorState(
                      failure: failure.message,
                      failureType: FailureType.error)),
                  (r) =>
                  emit(const SuccessState(
                      message: StringManager.theUserLogoutSuccessfully)));
        }
      } else {
        //do no thing

      }
    });
  }
}
