part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends LoginState{
  final String loadingIn;
  const LoadingState(this.loadingIn);
  @override
  List<Object?> get props => [];
}

class LoadedState extends LoginState{
  final UserCredential userCredential;
  const LoadedState(this.userCredential);
  @override
  List<Object?> get props => [userCredential];
}

class ErrorState extends LoginState{
  final Failure failure;

  const ErrorState(this.failure);
  @override
  List<Object?> get props => [failure];
}
