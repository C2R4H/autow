import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../backend/services/authentication.dart';

part 'forgotPassword_event.dart';
part 'forgotPassword_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordStateWaitingForInput()) {
    AuthMethods _authMethods = AuthMethods();

    bool emailValidate = false;
    String email = "";

    on<ForgotPasswordEmailSend>((event, emit) async {
      if (emailValidate) {
        emit(ForgotPasswordStateLoading());
        await _authMethods.sendPasswordResetEmail(email).then((e) {
          if (e == "success") {
            emit(ForgotPasswordStateSendEmail());
          } else {
            ForgotPasswordStateError(e);
            emit(ForgotPasswordStateWaitingForInput());
          }
        });
      }
    });

    on<ForgotPasswordEmailChanged>((event, emit) {
      emit(ForgotPasswordEmailCopyWith(event.email));
      RegExp regexp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (regexp.hasMatch(event.email)) {
        emit(ForgotPasswordStateValidate());
        email = event.email;
        emailValidate = true;
      } else {
        emailValidate = false;
        emit(ForgotPasswordStateWaitingForInput());
      }
    });
  }
}
