import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../backend/services/authentication.dart';
import '../../user_profile.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(LoginBlocStateWaitingForInput()) {
    AuthMethods _authMethods = AuthMethods();
    UserProfile userProfile = UserProfile();
    on<LoginSubmitted>((event, emit) async{
      print(event.validate);
      print(event.password);
      print(event.email);
      try{
        emit(LoginBlocStateWaitingForInput());
        if(event.validate){
          emit(LoginBlocStateLoading());
          if(await _authMethods.loginWithEmailAndPassword(event.email,event.password)){
            await userProfile.getData();
            emit(LoginBlocStateLoggedIn(userProfile));
            print(userProfile.username);
          }else{
            emit(LoginBlocStateError('Wrong data'));
        emit(LoginBlocStateWaitingForInput());
          }
        }else{
          emit(LoginBlocStateError('No text'));
        emit(LoginBlocStateWaitingForInput());
        }
      }catch(e){
        emit(LoginBlocStateError('NOT'));
        emit(LoginBlocStateWaitingForInput());
      }
    });

    on<OnButtonPressed>((event, emit) async {
      try {
        emit(LoginBlocStateWaitingForInput());
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
