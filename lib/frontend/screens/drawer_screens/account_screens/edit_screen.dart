import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import '../../../../midend/user_profile.dart';
import '../../../../midend/bloc/editAccount_bloc/editAccount_bloc.dart';

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
            listener: (context, state) {},
            child: ListView(
              children: [
                CircleAvatar(
                  backgroundImage: userProfile.profileImage == ""
                      ? null
                      : NetworkImage(userProfile.profileImage!),
                  radius: 60,
                  backgroundColor: Color(0xff414141),
                  child: userProfile.profileImage == ""
                      ? Text(
                          userProfile.username![0],
                          style: TextStyle(
                            fontSize: screen_height / 20,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
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
