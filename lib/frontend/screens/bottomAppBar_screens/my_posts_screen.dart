import 'package:flutter/material.dart';

class my_posts_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('My Posts'),
            backgroundColor: Color(0xff212121),
            ),
    body: Container(
        color: Color(0xff121212),
              child: Center(
                  child: Text(
                      'My posts screen',
                      style: TextStyle(
                          color: Colors.white,
                          ),
                      ),
                  ), 
              ),
        );
  }
}
