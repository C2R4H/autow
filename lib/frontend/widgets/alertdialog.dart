import 'package:flutter/material.dart';

AlertDialog errordialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Color(0xff212121),
    title: Text(
      'Error',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    content: Text(
      'Please check your email or password',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Ok',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

AlertDialog errorDialog(BuildContext context) {
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
                  'Please check your email or password.',
                  style: TextStyle(
                      color: Colors.white,
                      ),
                  ),
              ),
          SizedBox(height: MediaQuery.of(context).size.height/45),
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

AlertDialog usernameerror(BuildContext context) {
  return AlertDialog(
    backgroundColor: Color(0xff212121),
    title: Text('Error'),
    content: Text('Username is already used by someone'),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Ok'),
      ),
    ],
  );
}
