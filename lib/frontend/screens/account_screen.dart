import 'package:flutter/material.dart';

class account_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('Account Screen'),
            backgroundColor: Color(0xff212121),
            ),
        body: Container(
            color: Color(0xff121212),
            child: Center(
                child: Text('Account screen'),
                ),
            ),
        );
  }
}
