part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();
}


class LoadUserDetailsEvent extends UserDetailsEvent{
  final String? userId;

  const LoadUserDetailsEvent({required this.userId});
  @override
  List<Object?> get props =>[];

}