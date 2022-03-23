import 'package:flutter/material.dart';

import '../../../midend/user_profile.dart';
import '../../widgets/profilePicture_widget.dart';
import '../../widgets/notLogged_widget.dart';
import 'account_screens/edit_screen.dart';

class account_screen extends StatefulWidget {
  UserProfile userProfile;
  account_screen(this.userProfile);
  @override
  account_screen_state createState() => account_screen_state();
}

class account_screen_state extends State<account_screen> {
  String login_information =
      "Please login to see your profile posts and change or add a profile picture.";

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: widget.userProfile.isAuthenticated!,
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Color(0xff212121),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        title: Text('Account Screen'),
      ),
      body: widget.userProfile.isAuthenticated!
          ? userLogged_screen(context, widget.userProfile, screen_height)
          : userNotLogged_widget(context, screen_width, screen_height,
              login_information, Icons.person_outlined),
    );
  }
}

Widget userLogged_screen(context, userProfile, screen_height) {
  return Container(
    padding: EdgeInsets.all(10),
    color: Colors.black,
    child: ListView(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profilePicture(100, userProfile),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProfile.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screen_height / 30,
                  ),
                ),
                Text(
                  '10.01.2001',
                  style: TextStyle(
                    color: Color(0xff414141),
                    fontSize: screen_height / 35,
                  ),
                ),
                Text(
                  'Soroca',
                  style: TextStyle(
                    color: Color(0xff414141),
                    fontSize: screen_height / 35,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 15),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => edit_screen(userProfile)),
            );
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color(0xff272727),
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text('Edit profile'),
          ),
        ),
      ],
    ),
  );
}
