import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../user_profile.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState>{
  AuthBloc() : super(AuthBlocStateInitialize()){
    UserProfile userProfile = UserProfile();

    on<AppStarted>((event, emit) async {
      try{
        emit(AuthBlocStateLoading());
        await userProfile.getData();
        if(userProfile.isAuthenticated!){
          emit(AuthBlocStateAuthenticated(userProfile));
        }else{
          emit(AuthBlocStateUnaunthenticated(userProfile));
        }
      }catch(e){
        emit(AuthBlocStateError(e.toString()));
      }
    });
  }
}
