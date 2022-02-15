import 'package:flutter/material.dart';

class edit_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff121212),
            title: Text('Edit profile'),
            ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: ListView(
                children: [
                  CircleAvatar(
                      radius: 40,
                      ),
                ],
                ),
            ),
        );
  }
}
