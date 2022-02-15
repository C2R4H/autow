import 'package:flutter/material.dart';

class favorites_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff212121),
            title: Text('Favorites'),
            ),
        body: Container(
            color: Color(0xff121212),
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
