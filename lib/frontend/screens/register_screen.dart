import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../backend/services/authentication.dart';
import '../widgets/alertdialog.dart';

import 'login_screen.dart';
import '../screen_controller.dart';

class register_screen extends StatefulWidget {
  @override
  register_screen_state createState() => register_screen_state();
}

class register_screen_state extends State<register_screen> {
  bool _passwordVisible = false;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = AuthMethods();

  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  bool register = false;

  //FormKey doesnt work properly so we are checking in another way
  errorFunction() {
    register = false;
  }
  successfulFunction(){
    register = true;
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

  void registerFunction(context) async {
    setState((){
      isLoading = true;
    });
    if (formKey.currentState!.validate() && register) {
      print('working');
     if(await authMethods.registerEmailAndPassword(
          emailTextController.text, passwordTextController.text,context,usernameTextController.text)){
       int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
     }else{
      showDialog(
          context: context,
          builder: (context) => errorDialog(context),
          barrierDismissible: false,
          );
    }
    }
    setState((){
      isLoading = false;
    });
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
      body: Container(
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
                'AutoWorld',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screen_height / 20,
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff424242),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff212121),
                      ),
                      child: TextFormField(
                        controller: usernameTextController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Color(0xffBABABA),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff424242),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff212121),
                      ),
                      child: TextFormField(
                        validator: (String? value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? successfulFunction() 
                              : errorFunction();
                        },
                        autofillHints: [AutofillHints.email],
                        controller: emailTextController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration.collapsed(
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff424242),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff212121),
                      ),
                      child: TextFormField(
                        validator: (val) {
                          return val!.length > 6 ? successfulFunction() : errorFunction();
                        },
                        controller: passwordTextController,
                        obscureText: !_passwordVisible,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
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
              SizedBox(height: 20),
              FlatButton(
                onPressed: () {
                  registerFunction(context);
                },
                color: Color(0xffFF7171),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                height: 45,
                child: Container(
                  alignment: Alignment.center,
                  width: screen_width,
                  child: isLoading ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white) : Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
              Spacer(),
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
                        MaterialPageRoute(builder: (context) => login_screen()),
                      );
                    },
                    child: Text(
                      'Already have an account ? Log In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
