import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget errorDialog(BuildContext context, String error) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      //backgroundColor: Color(0xff212121),
      title: Text(
        'Error',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Text('$error'),
      actions: <Widget>[
        CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () => Navigator.of(context).pop(),
            ),
      ],
    );
  } else if(Platform.isAndroid){
    return AlertDialog(
      backgroundColor: Color(0xff212121),
      title: Text(
        'Error',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              '$error',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          Container(
            height: 1,
            color: Colors.grey[800],
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Try Again',
                style: TextStyle(
                  color: Color(0xffFF7171),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
    return AlertDialog(
      backgroundColor: Color(0xff212121),
      title: Text(
        'Error',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              '$error',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 45),
          Container(
            height: 1,
            color: Colors.grey[800],
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Try Again',
                style: TextStyle(
                  color: Color(0xffFF7171),
                ),
              ),
            ),
          ),
        ],
      ),
    );
}
