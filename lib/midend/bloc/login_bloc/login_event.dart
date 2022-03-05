part of 'login_bloc.dart';

class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginBlocEvent {
  final String email;
  const LoginEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginBlocEvent {
  final String password;
  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginBlocEvent {
}
