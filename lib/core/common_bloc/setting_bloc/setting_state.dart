part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();
}

class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}

class ReBuildTheAppState extends SettingState{
  final String state;
  final Locale? locale;

  const ReBuildTheAppState({this.state='initial',this.locale});

  @override
  List<Object?> get props => [state,locale];

}

class UserEventState extends SettingState{
  final ThemeData theme;
  final String local;

  const UserEventState({required this.theme,required this.local});
  @override
  List<Object?> get props => [theme,local];
}

class LoadingState extends SettingState{

  const LoadingState();
  @override
  List<Object?> get props => [];
}

class ErrorState extends SettingState{
  final String failure;
  final FailureType failureType;

  const ErrorState({required this.failure, required this.failureType});
  @override
  List<Object?> get props => [failureType,failure];

}

class SuccessState extends SettingState{
  final String message;


  const SuccessState({required this.message,});
  @override
  List<Object?> get props => [message];

}