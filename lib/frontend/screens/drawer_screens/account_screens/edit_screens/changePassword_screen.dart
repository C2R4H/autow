import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../midend/bloc/editAccount_bloc/editAccount_bloc.dart';
import '../../../../../midend/user_profile.dart';

class changePassword_screen extends StatefulWidget{
  EditAccountBloc editAccountBloc;
  UserProfile userProfile;
  changePassword_screen(this.editAccountBloc, this.userProfile);

  @override
  changePassword_screen_state createState() => changePassword_screen_state();
}

class changePassword_screen_state extends State<changePassword_screen>{

  bool obscurePassword1 = false;
  bool obscurePassword2 = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: Text('Change Username'),
      ),
      body: RepositoryProvider.value(
        value: widget.editAccountBloc,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 15),
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
                child: TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !obscurePassword1,
                  onChanged: (username) {
                    widget.editAccountBloc.add(ChangeCurrentPasswordEvent(username));
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
                        Icon(Icons.lock, color: Color(0xffBABABA)),
                    suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        icon: Icon(
                            obscurePassword1 ? Icons.visibility : Icons.visibility_off,
                            color: obscurePassword1 ? Colors.lightBlue : Color(0xffBABABA),
                            ),
                        onPressed: (){
                          setState((){
                            obscurePassword1 = !obscurePassword1;
                          });
                        },
                        ),
                    hintText: 'Current Password',
                    hintStyle: TextStyle(
                      color: Color(0xffBABABA),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
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
                child: TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !obscurePassword2,
                  onChanged: (password) {
                    widget.editAccountBloc.add(ChangeNewPasswordEvent(password));
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
                        Icon(Icons.lock_outlined, color: Color(0xffBABABA)),
                    suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        icon: Icon(
                            obscurePassword2 ? Icons.visibility : Icons.visibility_off,
                            color: obscurePassword2 ? Colors.lightBlue : Color(0xffBABABA),
                            ),
                        onPressed: (){
                          setState((){
                            obscurePassword2 = !obscurePassword2;
                          });
                        },
                        ),
                    hintText: 'New Password',
                    hintStyle: TextStyle(
                      color: Color(0xffBABABA),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              BlocListener(
                bloc: widget.editAccountBloc,
                listener: (context, state){
                  if (state is EditAccountStateError) {
                    print(state.message);
                  }
                  if(state is EditAccountStatePasswordSend){
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<EditAccountBloc, EditAccountState>(
                    builder: (context, state) {
                      if(state is EditAccountStateLoading){
                        return CircularProgressIndicator.adaptive();
                      }
                  if (state is EditAccountStateCurrentPasswordAndNewPasswordValidate) {
                    return change_button(widget.editAccountBloc,
                        MediaQuery.of(context).size.width, true, widget.userProfile);
                  }
                    return change_button(widget.editAccountBloc,
                        MediaQuery.of(context).size.width, false, widget.userProfile);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget change_button(editAccountBloc, screen_width, bool enabled, userProfile) {
  return TextButton(
      onPressed: enabled
          ? () {
              editAccountBloc.add(SubmitPasswordEvent());
            }
          : null,
      style: TextButton.styleFrom(
        primary: Colors.black,
        backgroundColor: enabled ? Color(0xff51A0D5) : Color(0xff2C528C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Container(
        height: 30,
        alignment: Alignment.center,
        width: screen_width,
        child: Text('Change', style: TextStyle(color: Colors.white)),
      ));
}
