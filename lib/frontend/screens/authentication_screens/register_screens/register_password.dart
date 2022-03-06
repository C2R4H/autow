import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../midend/bloc/register_bloc/register_bloc.dart';

class register_password extends StatefulWidget{
  BuildContext context;
  RegisterBloc _registerBloc;
  register_password(this.context,this._registerBloc);
  @override
  register_password_state createState() => register_password_state();
}

class register_password_state extends State<register_password>{

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  Widget build(BuildContext context){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'Create a password',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(height: 10),
        Flexible(
          child: Text(
            'Choose a safe and unique password.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w300,
              fontSize: 15,
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
          child: TextField(
            textInputAction: TextInputAction.next,
            autofocus: true,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (password) {
              widget._registerBloc.add(RegisterEventPasswordChanged(password));
            },
            style: TextStyle(
              color: Colors.white,
            ),
            textAlignVertical: TextAlignVertical.center,
            obscureText: obscureConfirmPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.lock_outlined, color: Color(0xffBABABA)),
              suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  splashColor: Colors.transparent,
                  icon: Icon(
                      !obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      color: !obscureConfirmPassword ? Colors.lightBlue : Color(0xffBABABA),
                      ),
                  onPressed: () {
                    setState((){
                      obscureConfirmPassword = !obscureConfirmPassword;
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
        SizedBox(height: 10),
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
          child: TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (password) {
              widget._registerBloc.add(RegisterEventConfirmPasswordChanged(password));
            },
            style: TextStyle(
              color: Colors.white,
            ),
            textAlignVertical: TextAlignVertical.center,
            obscureText: obscureConfirmPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.lock, color: Color(0xffBABABA)),
              hintText: 'Confirm Password',
              suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  splashColor: Colors.transparent,
                  icon: Icon(
                      !obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: !obscurePassword ? Colors.lightBlue : Color(0xffBABABA),
                      ),
                  onPressed: () {
                    setState((){
                      obscurePassword = !obscurePassword;
                    });
                  },
                  ),
              hintStyle: TextStyle(
                color: Color(0xffBABABA),
                fontSize: 15,
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        BlocBuilder<RegisterBloc, RegisterBlocState>(builder: (context, state) {
          if (state is RegisterBlocStatePasswordandConfirmPasswordValid) {
            return register_button(widget._registerBloc,MediaQuery.of(context).size.width, true);
          }
          return register_button(widget._registerBloc,MediaQuery.of(context).size.width, false);
        }),
      ],
    ),
  );
  }
}

Widget register_button(_registerBloc, screen_width, bool enabled) {
  return TextButton(
      onPressed: enabled
          ? () {
              _registerBloc.add(RegisterEventPasswordSubmitted());
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
        child: Text('Next', style: TextStyle(color: Colors.white)),
      ));
}
