part of 'register_bloc.dart';

class RegisterBlocState extends Equatable{
  String? username;
  String? email;
  String? password;
  String? confirmPassword;

  @override
  List<Object?> get props => [username,email,password,confirmPassword];
}

class RegisterBlocStateInputWait extends RegisterBlocState{}

class RegisterBlocStateLoading extends RegisterBlocState{}

class RegisterBlocStateUsernameCopyWith extends RegisterBlocState{
  RegisterBlocStateUsernameCopyWith(username);}
class RegisterBlocStateUsernameValid extends RegisterBlocState{}
class RegisterBlocStateUsernameSubmitted extends RegisterBlocState{}

class RegisterBlocStateEmailCopyWith extends RegisterBlocState{
  RegisterBlocStateEmailCopyWith(email);}
class RegisterBlocStateEmailValid extends RegisterBlocState{}

class RegisterBlocStatePasswordCopyWith extends RegisterBlocState{
  RegisterBlocStatePasswordCopyWith(password);}
class RegisterBlocStatePasswordValid extends RegisterBlocState{}

class RegisterBlocStateConfirmPasswordCopyWith extends RegisterBlocState{
  RegisterBlocStateConfirmPasswordCopyWith(confirmPassword);}
class RegisterBlocStateConfirmPasswordValid extends RegisterBlocState{}

class RegisterBlocStatePasswordandConfirmPasswordValid extends RegisterBlocState{}
class RegisterBlocStatePasswordButtonActivate extends RegisterBlocState{}

class RegisterBlocStateRegistered extends RegisterBlocState{}
class RegisterBlocStateInValid extends RegisterBlocState{}

class RegisterBlocStateError extends RegisterBlocState{
  final String message;
  RegisterBlocStateError(this.message);

  @override
  List<Object> get props => [message];
}
