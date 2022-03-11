import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/alertdialog.dart';

import 'register_screen.dart';
import 'forgotten_password.dart';
import '../../screen_controller.dart';

import '../../../midend/bloc/login_bloc/login_bloc.dart';

class login_screen extends StatefulWidget {
  @override
  login_screen_state createState() => login_screen_state();
}

class login_screen_state extends State<login_screen> {
  bool _passwordVisible = false;
  final LoginBloc _loginBloc = LoginBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
  }

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
        create: (context) => _loginBloc,
        child: 
           Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: screen_width,
            height: screen_height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  Text(
                    'AutoW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screen_height / 20,
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff212121),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff272727),
                          ),
                          child: TextFormField(
                            autofillHints: [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (email) {
                              _loginBloc.add(LoginEmailChanged(email));
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              disabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.person_outlined,
                                  color: Color(0xffBABABA)),
                              hintText: 'Username or email address',
                              hintStyle: TextStyle(
                                color: Color(0xffBABABA),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff212121),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff272727),
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (password) {
                              _loginBloc.add(LoginPasswordChanged(password));
                            },
                            obscureText: !_passwordVisible,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.lock_outlined,
                                  color: Color(0xffBABABA)),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                splashColor: Colors.transparent,
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: _passwordVisible
                                      ? Colors.lightBlue
                                      : Color(0xffBABABA),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color(0xffBABABA),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgotten_password()),
                        );
                      },
                      child: Text(
                        'Forgotten password ?',
                        style: TextStyle(
                          color: Color(0xff51A0D5),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  BlocListener(
                    bloc: _loginBloc,
                    listener: (context, state) {
                      if (state is LoginBlocStateLoggedIn) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                screen_controller(),
                            transitionDuration: const Duration(seconds: 0),
                          ),
                        );
                      }
                      if (state is LoginBlocStateError) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              errorDialog(context, state.message),
                          barrierDismissible: false,
                        );
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginBlocState>(
                        builder: (context, state) {
                      if (state is LoginBlocStateLoading) {
                        return const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white);
                      }
                      if (state is LoginBlocStateValidate) {
                        return login_button(
                          _loginBloc,
                          screen_width,
                          true,
                        );
                      }
                      return login_button(
                        _loginBloc,
                        screen_width,
                        false,
                      );
                    }),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  Container(
                    width: screen_width,
                    color: Colors.grey[800],
                    height: 1,
                  ),
                  Flexible(
                    flex: 1,
                    child: SafeArea(
                        child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => register_screen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account ?',
                            style: TextStyle(
                              color: Color(0xff676767),
                              fontWeight: FontWeight.w300,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: " Register",
                                style: TextStyle(color: Color(0xff51A0D5)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

Widget login_button(_loginBloc, screen_width, bool enabled) {
  return TextButton(
      onPressed: enabled
          ? () {
              _loginBloc.add(LoginSubmitted());
            }
          : null,
      style: TextButton.styleFrom(
        primary: Colors.black,
        //backgroundColor: Color(0xff2C528C),
        backgroundColor: enabled ? Color(0xff51A0D5) : Color(0xff2C528C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Container(
        height: 30,
        alignment: Alignment.center,
        width: screen_width,
        child: Text('Login', style: TextStyle(color: Colors.white)),
      ));
}
