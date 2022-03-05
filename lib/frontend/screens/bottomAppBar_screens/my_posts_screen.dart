import 'package:flutter/material.dart';

class my_posts_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('My Posts'),
            ),
    body: Container(
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
