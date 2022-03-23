import 'package:flutter/material.dart';
import '../../widgets/notLogged_widget.dart';
import '../../../midend/user_profile.dart';

import 'add_post_screens/brands.dart';

class add_post_screen extends StatelessWidget {
  UserProfile userProfile;
  add_post_screen(this.userProfile);

  final String information_text =
      "Please login in to add a new post and to sell your car with a good price.";

  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery.of(context).size.width;
    final double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: userProfile.isAuthenticated!
          ? Container(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vechicle',
                      style: TextStyle(
                        color: Color(0xffBABABA),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'Brand*',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          tileColor: Color(0xff121212),
                          shape: Border(
                              top: BorderSide(width: 1, color: Color(0xff212121),),
                              bottom: BorderSide(width: 1, color: Color(0xff212121),),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => brands()),
                                );
                          },
                        ),
                        ListTile(
                          leading: Text(
                            'Steering Wheel*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color(0xffBABABA)),
                          ),
                          shape: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff212121),),
                          ),
                          tileColor: Color(0xff121212),
                          onTap: () => print('working'),
                        ),
                        ListTile(
                          leading: Text(
                            'Year*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color(0xffBABABA)),
                          ),
                          tileColor: Color(0xff121212),
                          onTap: () => print('working'),
                          shape: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff212121),),
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'Body*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color(0xffBABABA)),
                          ),
                          tileColor: Color(0xff121212),
                          onTap: () => print('working'),
                          shape: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff313131),),
                          ),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          trailing: Icon(Icons.arrow_forward_ios),
                          leading: Text(
                            'Fuel Type*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                            ),
                          ),
                          tileColor: Color(0xff212121),
                          onTap: () => print('working'),
                          shape: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff313131),),
                          ),
                        ),
                        ListTile(
                          trailing: Icon(Icons.arrow_forward_ios),
                          leading: Text(
                            'Transmission*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                            ),
                          ),
                          tileColor: Color(0xff212121),
                          onTap: () => print('working'),
                          shape: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff313131),),
                          ),
                        ),
                        ListTile(
                          trailing: Icon(Icons.arrow_forward_ios),
                          leading: Text(
                            'Drivetrain*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                            ),
                          ),
                          tileColor: Color(0xff212121),
                          onTap: () => print('working'),
                          shape: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff313131),),
                          ),
                        ),
                        ListTile(
                          trailing: Text('cm3',style: TextStyle(color: Color(0xffBABABA))),
                          leading: Text(
                            'Engine Capacity*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color(0xffBABABA),
                            ),
                          ),
                          tileColor: Color(0xff212121),
                          onTap: () => print('working'),
                          shape: Border(
                              bottom: BorderSide(width: 1, color: Color(0xff313131),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : userNotLogged_widget(context, screen_width, screen_height,
              information_text, Icons.add_box),
    );
  }
}
