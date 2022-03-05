import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../backend/services/authentication.dart';
import '../../user_profile.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(LoginBlocStateWaitingForInput()) {
    AuthMethods _authMethods = AuthMethods();
    UserProfile userProfile = UserProfile();

    bool emailValidate = false;
    bool passwordValidate = false;

    String email = "";
    String password = "";
    on<LoginSubmitted>((event, emit) async {
      String code = "";
      try {
        emit(LoginBlocStateWaitingForInput());
        emit(LoginBlocStateLoading());
        await _authMethods
            .loginWithEmailAndPassword(email, password)
            .then((e) async {
          code = e;
          if (code == "success") {
            await userProfile.getData();
            emit(LoginBlocStateLoggedIn(userProfile));
          } else {
            emit(LoginBlocStateError(code));
            emit(LoginBlocStateWaitingForInput());
          }
        });
      } catch (e) {
        emit(LoginBlocStateError(code));
        emit(LoginBlocStateWaitingForInput());
      }
    });

    on<LoginEmailChanged>((event, emit) async {
      emit(LoginBlocStateEmailCopy(state.email));
      String pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regex = RegExp(pattern);
      if (regex.hasMatch(event.email)) {
        email = event.email;
        emit(LoginBlocStateEmailValid());
        emailValidate = true;
        if (passwordValidate) {
          emit(LoginBlocStateValidate());
        }
      } else {
        emit(LoginBlocStateInValid());
      }
    });

    on<LoginPasswordChanged>((event, emit) async {
      emit(LoginBlocStateEmailCopy(state.password));
      RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
      if (regex.hasMatch(event.password)) {
        password = event.password;
        emit(LoginBlocStatePasswordValid());
        passwordValidate = true;
        if (emailValidate) {
          emit(LoginBlocStateValidate());
        }
      } else {
        emit(LoginBlocStateInValid());
      }
    });
  }
}
