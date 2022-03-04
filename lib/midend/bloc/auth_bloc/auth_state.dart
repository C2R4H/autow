part of 'auth_bloc.dart';

class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object?> get props => [];
}

class AuthBlocStateInitialize extends AuthBlocState {}

class AuthBlocStateAuthenticated extends AuthBlocState {
  final UserProfile userProfile;
  const AuthBlocStateAuthenticated(this.userProfile);
}

class AuthBlocStateUnaunthenticated extends AuthBlocState{
  final UserProfile userProfile;
  const AuthBlocStateUnaunthenticated(this.userProfile);
}

class AuthBlocStateLoading extends AuthBlocState{}

class AuthBlocStateError extends AuthBlocState{
  final String? message;
  const AuthBlocStateError(this.message);
}
