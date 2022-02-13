import 'package:flutter/material.dart';

//Screens
import 'login_screen.dart';
import '../screen_controller.dart';

import '../../backend/services/authentication.dart';
import '../../backend/services/cache.dart';

class settings_screen extends StatefulWidget {
  bool? authState;
  settings_screen({this.authState});
  @override
  settings_screen_state createState() => settings_screen_state();
}

class settings_screen_state extends State<settings_screen> {
  AuthMethods authMethods = AuthMethods();

  checkState() async {
    widget.authState = await CacheMethods.getCachedUserLoggedInState();
  }

  void initState() {
    checkState();
  }

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
                  if (widget.authState!) {
                    authMethods.logout();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            screen_controller(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login_screen()),
                    );
                  }
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
                      widget.authState! ? 'Logout' : 'Log In',
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
