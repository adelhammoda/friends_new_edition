part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState extends Equatable{}

class HomepageInitial extends HomepageState {
  @override
  List<Object?> get props => [];
}


class UserNotLoadedState extends HomepageState{
  @override
  List<Object?> get props =>[];
}

class StudentState extends HomepageState{
  final UserEntity user;

  StudentState(this.user);
  @override

  List<Object?> get props => [];

}

class CenterState extends HomepageState{
  final UserEntity user;

  CenterState(this.user);
  @override
  List<Object?> get props => [];
}