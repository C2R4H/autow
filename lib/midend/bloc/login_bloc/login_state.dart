part of 'login_bloc.dart';


class LoginBlocState extends Equatable{
  bool? validate;
  String? email;
  String? password;

  @override
  List<Object?> get props => [email, password, validate];
}

class LoginBlocStateWaitingForInput extends LoginBlocState{}

class LoginBlocStateLoading extends LoginBlocState{}

class LoginBlocStateLoggedIn extends LoginBlocState{
  final UserProfile userProfile;
  LoginBlocStateLoggedIn(this.userProfile);
}

class LoginBlocStateError extends LoginBlocState{
  final String? message;
  LoginBlocStateError(this.message);
}

