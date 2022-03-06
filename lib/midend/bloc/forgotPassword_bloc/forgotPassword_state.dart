part of 'forgotPassword_bloc.dart';

class ForgotPasswordState extends Equatable{
  String? email;

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordStateWaitingForInput extends ForgotPasswordState{}
class ForgotPasswordStateLoading extends ForgotPasswordState{}

class ForgotPasswordEmailCopyWith extends ForgotPasswordState{
  ForgotPasswordEmailCopyWith(email);
}

class ForgotPasswordStateValidate extends ForgotPasswordState{}
class ForgotPasswordStateSendEmail extends ForgotPasswordState{}

class ForgotPasswordStateError extends ForgotPasswordState{
  final String message;
  ForgotPasswordStateError(this.message);
}
