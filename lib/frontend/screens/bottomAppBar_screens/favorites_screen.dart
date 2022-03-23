import 'package:flutter/material.dart';
import '../../widgets/notLogged_widget.dart';
import '../../../midend/user_profile.dart';

class favorites_screen extends StatelessWidget{
  UserProfile userProfile;
  favorites_screen(this.userProfile);

  final String information_text = "Please login in to save your favorites and know when price changes on all of your devices";

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
            title: Text('Favorites'),
            centerTitle: false,
            ),
        body: userProfile.isAuthenticated! ?  Container() : userNotLogged_widget(context,screen_width,screen_height,information_text,Icons.favorite_outline),
        );
  }
}
