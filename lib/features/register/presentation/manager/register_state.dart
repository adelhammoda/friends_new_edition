part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends RegisterState{
  final String loadingIn;
  const LoadingState(this.loadingIn);

  @override
  List<Object?> get props =>[loadingIn];
}
class LoadedState extends RegisterState{
  final UserCredential userCredential;

  const LoadedState(this.userCredential);

  @override
  List<Object?> get props => [userCredential];

}
class ErrorState extends RegisterState{
  final Failure failure;

  const ErrorState(this.failure);

  @override
  List<Object?> get props => [failure];

}