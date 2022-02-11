import 'package:flutter/material.dart';

//Screens
import 'login_screen.dart';
import 'signup_screen.dart';

class settings_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xff212121),
      ),
      body: Container(
        color: Color(0xff121212),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login_screen()),
                      );
                  print("Login Screen");
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Color(0xff212121),
                    border: Border(
                      top: BorderSide(
                        color: Color(0xff424242),
                      ),
                      bottom: BorderSide(
                        color: Color(0xff424242),
                      ),
                    ),
                  ),
                  width: screen_width,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Color(0xffFF7171),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
