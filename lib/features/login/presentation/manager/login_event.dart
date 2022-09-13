part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithEmailAndPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPasswordEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogleEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginWithAppleEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginWithFacebookEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordNavigatorEvent extends LoginEvent {
  final BuildContext context;

  const ForgetPasswordNavigatorEvent(this.context);

  @override
  List<Object?> get props => [];
}

class CreateAccountNavigatorEvent extends LoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  const CreateAccountNavigatorEvent({
    required this.context,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}
