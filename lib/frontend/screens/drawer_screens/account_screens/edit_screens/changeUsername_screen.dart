import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../midend/bloc/editAccount_bloc/editAccount_bloc.dart';
import '../../../../../midend/user_profile.dart';

class changeUsername_screen extends StatelessWidget {
  EditAccountBloc editAccountBloc;
  UserProfile userProfile;
  changeUsername_screen(this.editAccountBloc, this.userProfile);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: Text('Change Username'),
      ),
      body: RepositoryProvider.value(
        value: editAccountBloc,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
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
                child: TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (username) {
                    editAccountBloc.add(ChangeUsernameEvent(username));
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
                        Icon(Icons.person_outlined, color: Color(0xffBABABA)),
                    hintText: 'New Username',
                    hintStyle: TextStyle(
                      color: Color(0xffBABABA),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              BlocListener(
                bloc: editAccountBloc,
                listener: (context, state){
                  if (state is EditAccountStateError) {
                    print(state.message);
                  }
                  if(state is EditAccountStateUsernameSend){
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<EditAccountBloc, EditAccountState>(
                    builder: (context, state) {
                      if(state is EditAccountStateLoading){
                        return CircularProgressIndicator.adaptive();
                      }
                  if (state is EditAccountStateUsernameValidate) {
                    return change_button(editAccountBloc,
                        MediaQuery.of(context).size.width, true, userProfile);
                  }
                    return change_button(editAccountBloc,
                        MediaQuery.of(context).size.width, false, userProfile);
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
              editAccountBloc.add(SubmitUsernameEvent(userProfile));
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
