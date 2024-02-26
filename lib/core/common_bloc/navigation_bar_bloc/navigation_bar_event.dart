part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarEvent {}


class Animate extends NavigationBarEvent{
  final int index;
  Animate(this.index);
}