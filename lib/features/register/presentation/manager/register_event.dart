part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class SignupWithGoogle extends RegisterEvent{
  const SignupWithGoogle();

  @override
  List<Object?> get props => [];
}
class SignupWithFacebook extends RegisterEvent{
 const  SignupWithFacebook();
  @override
  List<Object?> get props => [];
}
class SignupWithApple extends RegisterEvent{

 const  SignupWithApple();
  @override
  List<Object?> get props => [];
}
class SignupWithEmailAndPassword extends RegisterEvent{
  final String password;
  final UserModel userModel;
  const SignupWithEmailAndPassword(this.userModel,this.password,);
  @override
  List<Object?> get props => [userModel,password];
}

class AlreadyHaveAccountNavigator extends RegisterEvent{
  final BuildContext context;
  const AlreadyHaveAccountNavigator(this.context);
  @override
  List<Object?> get props => [];
}