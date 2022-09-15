part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class SignupWithGoogle extends RegisterEvent{
  final UserModel userModel;
  const SignupWithGoogle(this.userModel);

  @override
  List<Object?> get props => [userModel];
}
class SignupWithFacebook extends RegisterEvent{
  final UserModel userModel;
 const  SignupWithFacebook(this.userModel);
  @override
  List<Object?> get props => [userModel];
}
class SignupWithApple extends RegisterEvent{
  final UserModel userModel;
 const  SignupWithApple(this.userModel);
  @override
  List<Object?> get props => [userModel];
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