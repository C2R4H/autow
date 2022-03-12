import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../midend/user_profile.dart';
import '../../../../midend/bloc/editAccount_bloc/editAccount_bloc.dart';
import '../../../widgets/alertdialog.dart';
import '../../../widgets/profilePicture_widget.dart';

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
              if(state is EditAccountStateError){
                showDialog(
                    context: context,
                    builder: (context) => errorDialog(context, state.message),
                    );
              }
            },
            child: Column(
              children: [
                profilePicture(100,userProfile),
                BlocBuilder<EditAccountBloc, EditAccountState>(
                    bloc: editAccountBloc,
                    builder: (context, state) {
                      if(state is EditAccountStateLoading){
                        return const CircularProgressIndicator.adaptive();
                      }
                      return TextButton(
                        onPressed: () {
                          editAccountBloc.add(ChangeProfilePictureEvent(userProfile));
                        },
                        child: Container(
                          child: Text('Upload image'),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
