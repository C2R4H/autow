import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../backend/services/authentication.dart';
import '../../widgets/alertdialog.dart';

import 'login_screen.dart';
import 'register_screens/register_password.dart';
import '../../screen_controller.dart';

import '../../../midend/bloc/register_bloc/register_bloc.dart';

part 'register_screens/register_username.dart';
part 'register_screens/register_email.dart';

class register_screen extends StatefulWidget {
  @override
  register_screen_state createState() => register_screen_state();
}

class register_screen_state extends State<register_screen> {
  RegisterBloc _registerBloc = RegisterBloc();

  bool usernameSubmitting = false;
  bool passwordSubmitting = false;

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        elevation: 0,
      ),
      backgroundColor: Color(0xff121212),
      body: BlocProvider(
        create: (context) => _registerBloc,
        child: BlocListener(
          bloc: _registerBloc,
          listener: (context, state) {
            if (state is RegisterBlocStateRegistered) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      screen_controller(),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
            }
            if(state is RegisterBlocStateError){
              showDialog(
                  context: context,
                  builder: (context) => errorDialog(context, state.message),
                  barrierDismissible: false,
                  );
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterBlocState>(
              builder: (context, state) {
            if (state is RegisterBlocStateUsernameSubmitted) {
              usernameSubmitting = true;
            }
            if (state is RegisterBlocStatePasswordButtonActivate) {
              passwordSubmitting = true;
            }
            if (usernameSubmitting && !passwordSubmitting) {
              return register_password(context, _registerBloc);
            }
            if (passwordSubmitting) {
              return register_email(context, _registerBloc);
            }
            return register_username(context, _registerBloc);
          }),
        ),
      ),
    );
  }
}
