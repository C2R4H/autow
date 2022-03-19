import 'package:flutter/material.dart';
import '../screens/authentication_screens/login_screen.dart';

Widget userNotLogged_widget(context,screen_width, screen_height,String login_information,IconData icon) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        Icon(icon, size: screen_height / 10, color: Color(0xff313131)),
        const Spacer(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text('Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screen_height/20,
                  ),
              ),
        ),
        SizedBox(height: 15),
        Text(
          login_information,
          style: TextStyle(
            color: Color(0xffBABABA),
          ),
        ),
        SizedBox(height: 15),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login_screen()),
                );
          },
          child: Text('Login'),
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Color(0xff51A0D5),
            minimumSize: Size(screen_width, screen_height / 15),
          ),
        ),
      ],
    ),
  );
}
