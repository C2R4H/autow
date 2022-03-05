import 'package:flutter/material.dart';

class messages_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Messages'),
          ),
      body: Container(
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
