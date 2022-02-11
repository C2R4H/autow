import 'package:flutter/material.dart';

import '../screen_controller.dart';
import 'settings_screen.dart';
import 'add_post_screen.dart';
import 'account_screen.dart';

import '../widgets/post_half_widget.dart';
import '../../backend/services/cache.dart';
import '../../midend/user_profile.dart';

class home_screen extends StatefulWidget {
  bool? authState;
  String? userProfile;
  home_screen({this.authState,this.userProfile});
  @override
  home_screen_state createState() => home_screen_state();
}

class home_screen_state extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    String username = "";

    checkState() async {
      if(widget.userProfile!=null){
        username = widget.userProfile!;
      }
      widget.authState = await CacheMethods.getCachedUserLoggedInState();
    }

    void initState(){
      checkState();
      super.initState();
    }

    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Color(0xff212121),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: screen_height / 4,
                color: Color(0xff121212),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff424242),
                      radius: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.userProfile!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Color(0xff424242),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => account_screen()),
                  );
                },
                leading: Icon(
                  Icons.person_outlined,
                  color: Color(0xffBABABA),
                  size: screen_height / 25,
                ),
                title: Text(
                  'My account',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: screen_height / 35,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => add_post_screen()),
                  );
                },
                leading: Icon(
                  Icons.add_box,
                  color: Color(0xffBABABA),
                  size: screen_height / 25,
                ),
                title: Text(
                  'Add a post',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: screen_height / 35,
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  await checkState();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settings_screen(authState: widget.authState)),
                  );
                },
                leading: Icon(
                  Icons.settings,
                  color: Color(0xffBABABA),
                  size: screen_height / 25,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: screen_height / 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // this will hide Drawer hamburger icon
        toolbarHeight: MediaQuery.of(context).size.height/6,
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          color: Color(0xff212121),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    Text(
                      'AutoWorld',
                      style: TextStyle(
                        fontSize: screen_height / 30,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.menu, color: Color(0xff212121)),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xff121212),
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: screen_width / 30,
          ),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                post_half_widget(context),
                post_half_widget(context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                post_half_widget(context),
                post_half_widget(context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                post_half_widget(context),
                post_half_widget(context),
              ],
            ),

            //This will go in widget folder!
            /*Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4.5,
                    color: Colors.red,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          'BMW M4 Competition',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(Model 2021)',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '\$33,000',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
