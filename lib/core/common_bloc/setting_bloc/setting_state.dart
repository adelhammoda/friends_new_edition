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

  const ReBuildTheAppState({this.state='initial'});

  @override
  List<Object?> get props => [state];

}
