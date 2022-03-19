import 'package:flutter/material.dart';
import '../../widgets/notLogged_widget.dart';
import '../../../midend/user_profile.dart';

class messages_screen extends StatelessWidget{
  UserProfile userProfile;
  messages_screen(this.userProfile);

  final String information_text = "Please login in to see your chats and get notified when someone messages you.";

  @override
  Widget build(BuildContext context){

    final double screen_width = MediaQuery.of(context).size.width;
    final double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            title: Text('Messages'),
            ),
        body: userProfile.isAuthenticated! ?  Container() : userNotLogged_widget(context,screen_width,screen_height,information_text,Icons.mail_outlined),
        );
  }
}
