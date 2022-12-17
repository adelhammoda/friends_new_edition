part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}


class RebuildTheAppEvent extends SettingEvent{
  final String event;

  const RebuildTheAppEvent({this.event="initial"});


  @override
  List<Object?> get props =>[event];

}
