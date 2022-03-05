import 'package:flutter/material.dart';

class favorites_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('Favorites'),
            ),
        body: Container(
            child: Center(
                child: Text(
                    'Favorites Screen',
                    style: TextStyle(
                        color: Colors.white,
                        ),
                    ),
               ),
            ),
        );
  }
}
