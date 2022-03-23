import 'package:flutter/material.dart';
import '../../widgets/notLogged_widget.dart';
import '../../../midend/user_profile.dart';

class posts_screen extends StatelessWidget{
  UserProfile userProfile;
  posts_screen(@required this.userProfile);

  final String information_text = "Please login in to see your posts and how many people visited.";

  @override
  Widget build(BuildContext context){

    final double screen_width = MediaQuery.of(context).size.width;
    final double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: const Color(0xff212121),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
            title: Text('Posts'),
            centerTitle: false,
            ),
        body: userProfile.isAuthenticated! ?  Container() : userNotLogged_widget(context,screen_width,screen_height,information_text,Icons.grid_on_outlined),
        );
  }
}
