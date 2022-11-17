part of 'user_details_bloc.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();
}

class UserDetailsInitial extends UserDetailsState {
  @override
  List<Object> get props => [];
}

class LoadingUserDetailsState extends UserDetailsState{
  @override
  List<Object?> get props => [];

}
class LoadedUserDetailsState extends UserDetailsState{
  final UserEntity userEntity;

  const LoadedUserDetailsState({required this.userEntity});
  @override
  List<Object?> get props => [];

}class ErrorUserDetailsState extends UserDetailsState{
  final Failure failure;

  const ErrorUserDetailsState({required this.failure});
  @override
  List<Object?> get props => [];

}
