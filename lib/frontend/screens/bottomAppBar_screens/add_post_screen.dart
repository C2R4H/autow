import 'package:flutter/material.dart';

import '../../screen_controller.dart';

class add_post_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('New Post'),
        ),
        body: Container(
            child: Center(
                child: Text('New Post'),
                ), 
            ),
        );
  }
}
