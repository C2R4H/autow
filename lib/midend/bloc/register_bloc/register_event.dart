part of 'register_bloc.dart';

class RegisterBlocEvent extends Equatable{
  const RegisterBlocEvent();

  @override
  List<Object> get props => [];
}

class RegisterEventSubmitted extends RegisterBlocEvent{}
class RegisterEventUsernameSubmitted extends RegisterBlocEvent{}
class RegisterEventPasswordSubmitted extends RegisterBlocEvent{}
class RegisterEventEmailSubmitted extends RegisterBlocEvent{}

class RegisterEventEmailChanged extends RegisterBlocEvent{
  final String email;
  const RegisterEventEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class RegisterEventUsernameChanged extends RegisterBlocEvent{
  final String username;
  const RegisterEventUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class RegisterEventPasswordChanged extends RegisterBlocEvent{
  final String password;
  const RegisterEventPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RegisterEventConfirmPasswordChanged extends RegisterBlocEvent{
  final String confirmPassword;
  const RegisterEventConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

