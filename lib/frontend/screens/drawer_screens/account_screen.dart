import 'package:flutter/material.dart';

import '../../../midend/user_profile.dart';
import '../../widgets/profilePicture_widget.dart';
import 'account_screens/edit_screen.dart';

class account_screen extends StatefulWidget {
  UserProfile userProfile;
  account_screen(this.userProfile);
  @override
  account_screen_state createState() => account_screen_state();
}

class account_screen_state extends State<account_screen> {
  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Account Screen'),
        backgroundColor: Color(0xff121212).withOpacity(0.92),
        elevation: 0,
      ),
      body: 
           Container(
        padding: EdgeInsets.symmetric( horizontal: 15),
        color: Colors.black,
        child: RefreshIndicator(
          color: Color(0xffFF7171),
          backgroundColor: Color(0xff212121),
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            setState(() {});
          },
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profilePicture(100,widget.userProfile),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userProfile.username!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screen_height / 30,
                        ),
                      ),
                      Text(
                        '10.01.2001',
                        style: TextStyle(
                          color: Color(0xff414141),
                          fontSize: screen_height / 35,
                        ),
                      ),
                      Text(
                        'Soroca',
                        style: TextStyle(
                          color: Color(0xff414141),
                          fontSize: screen_height / 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => edit_screen(widget.userProfile)),
                      );
                },
                style: TextButton.styleFrom(
                           primary: Colors.white,
                           backgroundColor: Color(0xff272727),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                           ),
                child: Container(
                  alignment: Alignment.center,
                  width: screen_width,
                  child: Text(
                          'Edit profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
