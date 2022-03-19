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
            title: Text('Favorites'),
            ),
        body: userProfile.isAuthenticated! ?  Container() : userNotLogged_widget(context,screen_width,screen_height,information_text,Icons.favorite_outline),
        );
  }
}
