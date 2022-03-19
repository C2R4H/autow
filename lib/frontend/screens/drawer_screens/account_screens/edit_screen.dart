import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../midend/user_profile.dart';
import '../../../../midend/bloc/editAccount_bloc/editAccount_bloc.dart';
import '../../../widgets/alertdialog.dart';
import '../../../widgets/profilePicture_widget.dart';

import 'edit_screens/changeUsername_screen.dart';
import 'edit_screens/changePassword_screen.dart';

class edit_screen extends StatelessWidget {
  UserProfile userProfile;
  edit_screen(this.userProfile);

  EditAccountBloc editAccountBloc = EditAccountBloc();

  @override
  Widget build(BuildContext context) {
    var screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: Text('Edit profile'),
      ),
      body: BlocProvider(
        create: (context) => editAccountBloc,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: BlocListener(
            bloc: editAccountBloc,
            listener: (context, state) {
              if (state is EditAccountStateError) {
                showDialog(
                  context: context,
                  builder: (context) => errorDialog(context, state.message),
                );
              }
            },
            child: ListView(
              children: [
                Column(
                  children: [
                    profilePicture(100, userProfile),
                  ],
                ),
                BlocBuilder<EditAccountBloc, EditAccountState>(
                    bloc: editAccountBloc,
                    builder: (context, state) {
                      if (state is EditAccountStateLoading) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      return TextButton(
                        onPressed: () {
                          editAccountBloc
                              .add(ChangeProfilePictureEvent(userProfile));
                        },
                        child: Text('Change Profile Image'),
                      );
                    }),
                changeButton(context, true,editAccountBloc,userProfile),
                changeButton(context, false,editAccountBloc,userProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget changeButton(context, bool password,editAccountBloc,userProfile) {
  return TextButton(
    onPressed: password
        ? () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => changeUsername_screen(editAccountBloc,userProfile)));
          }
        : () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => changePassword_screen(editAccountBloc,userProfile)));
          },
    style: TextButton.styleFrom(
      backgroundColor: Color(0xff212121),
      primary: Colors.white,
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    child: Row(
      children: [
        Text(password ? 'Change Username' : 'Change Password'),
        const Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
