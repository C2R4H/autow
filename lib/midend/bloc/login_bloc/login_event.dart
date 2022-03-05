part of 'login_bloc.dart';

class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class OnButtonPressed extends LoginBlocEvent {
  @override
  String toString() => 'Loggin Process Started';
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
  final bool validate;
  final String email;
  final String password;

  const LoginSubmitted({required this.validate, required this.password, required this.email});

  @override
  List<Object> get props => [password, email, validate];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}
