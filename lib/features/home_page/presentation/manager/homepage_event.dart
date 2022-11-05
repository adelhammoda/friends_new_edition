part of 'homepage_bloc.dart';

@immutable
abstract class HomepageEvent extends Equatable {}

class LoadUserEvent extends HomepageEvent{
  final BuildContext context;

  LoadUserEvent(this.context);
  @override
  List<Object?> get props => [context];

}