import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../backend/services/authentication.dart';
import '../../../backend/services/firestore_database.dart';
import '../../user_profile.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(LoginBlocStateWaitingForInput()) {
    AuthMethods _authMethods = AuthMethods();
    UserProfile userProfile = UserProfile();
    FirestoreDatabaseMethods _firestoreDatabaseMethods =
        FirestoreDatabaseMethods();
    bool emailValidate = false;
    bool passwordValidate = false;

    bool username = false;

    String email = "";
    String password = "";
    on<LoginSubmitted>((event, emit) async {
      String code = "";
      try {
        emit(LoginBlocStateWaitingForInput());
        emit(LoginBlocStateLoading());
        if(username){
          email = await _firestoreDatabaseMethods.getUserByName(email);
        }
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
      emit(LoginBlocStateEmailCopy(event.email));

      //RegExp 
      RegExp regexpUsername =
          RegExp("^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]\$");
      String pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regexpEmail = RegExp(pattern);


      email = event.email;
      if (regexpUsername.hasMatch(event.email)) {
        emit(LoginBlocStateEmailValid());
        emailValidate = true;
        username = true;
        if (passwordValidate) {
          emit(LoginBlocStateValidate());
        }
      }else if(regexpEmail.hasMatch(event.email)){
        emit(LoginBlocStateEmailValid());
        emailValidate = true;
        username = false;
        if (passwordValidate) {
          emit(LoginBlocStateValidate());
        }
      } else {
        emit(LoginBlocStateInValid());
        emailValidate = false;
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
