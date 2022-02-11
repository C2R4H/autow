import 'package:flutter/material.dart';

class messages_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Messages'),
          backgroundColor: Color(0xff212121),
          ),
      body: Container(
        color: Color(0xff121212),
        child: Center(
          child: Text(
            'Messages Screen',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
