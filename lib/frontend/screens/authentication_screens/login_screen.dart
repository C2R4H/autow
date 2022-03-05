import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../backend/services/authentication.dart';
import '../../widgets/alertdialog.dart';

import 'register_screen.dart';
import '../../screen_controller.dart';

import '../../../midend/bloc/login_bloc/login_bloc.dart';

class login_screen extends StatefulWidget {
  @override
  login_screen_state createState() => login_screen_state();
}

class login_screen_state extends State<login_screen> {
  bool _passwordVisible = false;
  bool isLoading = false;
  final LoginBloc _loginBloc = LoginBloc();

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  bool login = false;

  successfulFunction(bool succesful) {
    login = succesful;
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();

    super.dispose();
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
        child: Container(
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
                            color: Color(0xff212121),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff272727),
                        ),
                        child: TextFormField(
                          validator: (String? value) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)
                                ? null
                                : null;
                          },
                          autofillHints: [AutofillHints.email],
                          controller: emailTextController,
                          textAlignVertical: TextAlignVertical.center,
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
                            hintText: 'Email',
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
                            color: Color(0xff212121),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff272727),
                        ),
                        child: TextFormField(
                          validator: (val) {
                            return val!.length > 6 ? null : null;
                          },
                          controller: passwordTextController,
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
                      primary: Colors.black,
                    ),
                    onPressed: () {},
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
                      print("LOGGED IN");
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
                    if (state is LoginBlocStateError) {
                      print("LOGIN ERROR");
                      showDialog(
                        context: context,
                        builder: (context) => errorDialog(context),
                        barrierDismissible: false,
                      );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginBlocState>(
                      builder: (context, state) {
                    print("NOTHING");
                    if (state is LoginBlocStateLoading) {
                      print("LOADING");
                      return const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white);
                    }
                    return login_button(
                        _formKey,
                        login,
                        _loginBloc,
                        passwordTextController,
                        emailTextController,
                        screen_width);
                  }),
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
                Container(
                  width: screen_width,
                  color: Color(0xffBABABA),
                  height: 1,
                ),
                Flexible(
                  flex: 1,
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
                            color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget login_button(_formKey, login, _loginBloc, passwordTextController,
    emailTextController, screen_width) {
  return TextButton(
    onPressed: () {
      print("${_formKey.currentState!.validate()} && $login");
      if (_formKey.currentState!.validate() && login) {
        _loginBloc.add(LoginSubmitted(
            validate: login,
            password: passwordTextController.text,
            email: emailTextController.text));
      }
    },
    style: TextButton.styleFrom(
      primary: Colors.black,
      //backgroundColor: Color(0xff2C528C),
      backgroundColor: Color(0xff51A0D5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    child: Container(
      height: 30,
      alignment: Alignment.center,
      width: screen_width,
      child: Text('Log In', style: TextStyle(color: Colors.white)),
    ),
  );
}
