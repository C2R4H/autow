import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../backend/services/authentication.dart';
import '../../user_profile.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterBlocEvent, RegisterBlocState> {
  RegisterBloc() : super(RegisterBlocStateInputWait()) {
    AuthMethods _authMethods = AuthMethods();
    UserProfile _userProfile = UserProfile();

    bool emailValidate = false;
    bool usernameValidate = false;
    bool passwordValidate = false;
    bool confirmPasswordValidate = false;
    String username = "";
    String email = "";
    String confirmPassword;
    String password = "";

    on<RegisterEventSubmitted>((event, emit) async {});

    on<RegisterEventUsernameSubmitted>((event, emit) async {
      if (usernameValidate) {
        emit(RegisterBlocStateUsernameSubmitted());
      }
    });

    on<RegisterEventPasswordSubmitted>((event, emit) async {
      if (passwordValidate && confirmPasswordValidate && usernameValidate) {
        emit(RegisterBlocStatePasswordButtonActivate());
      }
    });

    on<RegisterEventEmailSubmitted>((event, emit) async {
      if(emailValidate && passwordValidate && usernameValidate){
        print(email);
        print(password);
        print(username);
        emit(RegisterBlocStateLoading());
        await _authMethods.registerEmailAndPassword(email,password,username).then((e){
          if(e=="success"){
            emit(RegisterBlocStateRegistered());
          }else{
            emit(RegisterBlocStateError(e));
            emit(RegisterBlocStateInputWait());
          }
        });
      }
    });
    on<RegisterEventEmailChanged>((event, emit) async {
      emit(RegisterBlocStateEmailCopyWith(state.email));
      RegExp regex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (regex.hasMatch(event.email)) {
        email = event.email;
        emailValidate = true;
        emit(RegisterBlocStateEmailValid());
      } else {
        emailValidate = false;
      }
    });

    on<RegisterEventUsernameChanged>((event, emit) async {
      emit(RegisterBlocStateUsernameCopyWith(state.username));
      RegExp regex =
          RegExp("^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]\$");
      if (regex.hasMatch(event.username)) {
        username = event.username;
        usernameValidate = true;
        emit(RegisterBlocStateUsernameValid());
      } else {
        usernameValidate = false;
      }
    });

    on<RegisterEventPasswordChanged>((event, emit) async {
      emit(RegisterBlocStatePasswordCopyWith(state.password));
      RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
      if (regex.hasMatch(event.password)) {
        password = event.password;
        passwordValidate = true;
        emit(RegisterBlocStatePasswordValid());
        if (confirmPasswordValidate) {
          emit(RegisterBlocStatePasswordandConfirmPasswordValid());
        }
      } else {
        passwordValidate = false;
      }
    });

    on<RegisterEventConfirmPasswordChanged>((event, emit) async {
      emit(RegisterBlocStatePasswordCopyWith(state.password));
      if (event.confirmPassword == password) {
        confirmPassword = event.confirmPassword;
        confirmPasswordValidate = true;
        emit(RegisterBlocStateConfirmPasswordValid());
        if (passwordValidate) {
          emit(RegisterBlocStatePasswordandConfirmPasswordValid());
        }
      } else {
        confirmPasswordValidate = false;
      }
    });
  }
}
