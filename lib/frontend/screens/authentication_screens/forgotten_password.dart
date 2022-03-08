import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/alertdialog.dart';

import '../../../midend/bloc/forgotPassword_bloc/forgotPassword_bloc.dart';

class forgotten_password extends StatelessWidget {
  ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        elevation: 0,
      ),
      backgroundColor: const Color(0xff121212),
      body: BlocProvider(
        create: (_) => _forgotPasswordBloc,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Icon(Icons.lock_outlined, size: 50),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Trouble with logging in?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Flexible(
                child: Text(
                  'Enter your email address and we\'ll send you a link to get back into your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: 15),
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
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (email) {
                    _forgotPasswordBloc.add(ForgotPasswordEmailChanged(email));
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
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Color(0xffBABABA)),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Color(0xffBABABA),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              BlocListener(
                bloc: _forgotPasswordBloc,
                listener: (context, state) {
                  if (state is ForgotPasswordStateSendEmail) {
                    Navigator.pop(context);
                  }
                  if (state is ForgotPasswordStateError) {
                    showDialog(
                      context: context,
                      builder: (context) => errorDialog(context, state.message),
                      barrierDismissible: false,
                    );
                  }
                },
                child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state) {
                    if (state is ForgotPasswordStateLoading) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    if (state is ForgotPasswordStateValidate) {
                      return login_button(_forgotPasswordBloc,
                          MediaQuery.of(context).size.width, true);
                    }
                    return login_button(_forgotPasswordBloc,
                        MediaQuery.of(context).size.width, false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget login_button(ForgotPasswordBloc _forgotPasswordBloc,screen_width, bool enabled) {
  return TextButton(
      onPressed: enabled ? () {
        _forgotPasswordBloc.add(ForgotPasswordEmailSend());
      } : null,
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
        child: Text('Send', style: TextStyle(color: Colors.white)),
      ));
}
