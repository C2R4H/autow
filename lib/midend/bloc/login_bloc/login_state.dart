part of 'login_bloc.dart';


class LoginBlocState extends Equatable{
  String? email;
  String? password;

  @override
  List<Object?> get props => [email, password];
}

class LoginBlocStateWaitingForInput extends LoginBlocState{}

class LoginBlocStateLoading extends LoginBlocState{}

class LoginBlocStateLoggedIn extends LoginBlocState{}

class LoginBlocStateError extends LoginBlocState{
  final String message;
  LoginBlocStateError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginBlocStatePasswordCopy extends LoginBlocState{
  LoginBlocStatePasswordCopy(password);
}

class LoginBlocStateEmailValid extends LoginBlocState{
}
class LoginBlocStatePasswordValid extends LoginBlocState{
}

class LoginBlocStateValidate extends LoginBlocState{}

class LoginBlocStateInValid extends LoginBlocState{
}


class LoginBlocStateEmailCopy extends LoginBlocState{
  LoginBlocStateEmailCopy(email);
}

