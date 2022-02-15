import 'package:flutter/material.dart';

import '../../screen_controller.dart';

class add_post_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('Add Post'),
            backgroundColor: Color(0xff212121),
        ),
        body: Container(
            color: Color(0xff121212),
            child: Center(
                child: Text('Add Posts Screen'),
                ), 
            ),
        );
  }
}
