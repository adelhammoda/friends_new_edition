part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarState {}

class NavigationBarInitial extends NavigationBarState {}


class AnimateState extends NavigationBarState{
  final int index;

  AnimateState(this.index);

}
