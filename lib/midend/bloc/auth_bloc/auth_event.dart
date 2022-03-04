part of 'auth_bloc.dart';

class AuthBlocEvent extends Equatable{
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthBlocEvent{
  @override
  String toString() => 'AppStared';
}

class LoggedIn extends AuthBlocEvent {
  final String token;
  LoggedIn({required this.token});

  @override
  String toString() => "LoggedIn { token: $token }";
}

class LoggedOut extends AuthBlocEvent{
  @override
  String toString() => 'LoggedOut';
} 

