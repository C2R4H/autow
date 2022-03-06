import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget errorDialog(BuildContext context, String error) {
    return AlertDialog(
      backgroundColor: Color(0xff212121),
      title: Text(
        'Error',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Text('$error'),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
                       'Try Again',
                       style: TextStyle(
                       color: Color(0xffFF7171),
                       ),
                       ),
            ),
      ],
    );
}
