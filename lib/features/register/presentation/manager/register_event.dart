part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class SignupWithGoogle extends RegisterEvent{
  final BuildContext context;
  const SignupWithGoogle(this.context);

  @override
  List<Object?> get props => [context];
}
class SignupWithFacebook extends RegisterEvent{
  final BuildContext context;
 const  SignupWithFacebook(this.context);
  @override
  List<Object?> get props => [context];
}
class SignupWithApple extends RegisterEvent{
  final BuildContext context;
 const  SignupWithApple(this.context);
  @override
  List<Object?> get props => [context];
}
class SignupWithEmailAndPassword extends RegisterEvent{
  final BuildContext context;
  final String password;
  final UserModel userModel;
  const SignupWithEmailAndPassword(this.userModel,this.password, this.context,);
  @override
  List<Object?> get props => [userModel,password,context];
}

class AlreadyHaveAccountNavigator extends RegisterEvent{
  final BuildContext context;
  const AlreadyHaveAccountNavigator(this.context);
  @override
  List<Object?> get props => [];
}