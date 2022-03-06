part of 'forgotPassword_bloc.dart';

class ForgotPasswordEvent extends Equatable{
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent{
  final String email;
  const ForgotPasswordEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class ForgotPasswordEmailSend extends ForgotPasswordEvent{}

