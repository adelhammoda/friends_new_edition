part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class RebuildTheAppEvent extends SettingEvent {
  final String event;
  final bool isDark;

  const RebuildTheAppEvent({
    this.event = "initial",
    required this.isDark,
  });

  @override
  List<Object?> get props => [event, isDark];
}

class LogoutEvent extends SettingEvent {
  final String? userEmail;
  final BuildContext context;

  const LogoutEvent({
    required this.userEmail ,
    required this.context,
  });

  @override
  List<Object?> get props => [userEmail,context];
}

class DeleteAccountEvent extends SettingEvent {
  final String? userEmail;
  final BuildContext context;

  const DeleteAccountEvent({
    required this.userEmail ,
    required this.context,
  });

  @override
  List<Object?> get props => [userEmail,context];
}

class LoadUserPreferencesEvent extends SettingEvent {
  const LoadUserPreferencesEvent();

  @override
  List<Object?> get props => [];
}
