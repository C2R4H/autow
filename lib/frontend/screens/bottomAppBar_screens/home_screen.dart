import 'package:flutter/material.dart';

import '../../screen_controller.dart';
import '../drawer_screens/settings_screen.dart';
import '../bottomAppBar_screens/add_post_screen.dart';
import '../drawer_screens/account_screen.dart';

import '../../widgets/post_half_widget.dart';
import '../../../backend/services/cache.dart';
import '../../../midend/user_profile.dart';

class home_screen extends StatefulWidget {
  UserProfile? userProfile;
  home_screen({this.userProfile});
  @override
  home_screen_state createState() => home_screen_state();
}

class home_screen_state extends State<home_screen> {
  String username = '';

  @override
  void initState() {
    username = widget.userProfile!.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: screen_height / 4,
                color: Colors.black,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: widget.userProfile!.profileImage == "" ? null : NetworkImage(widget.userProfile!.profileImage!),
                      backgroundColor: Color(0xff424242),
                      radius: 40,
                      child: widget.userProfile!.profileImage! == "" ? Text(
                          username[0],
                          style:TextStyle(
                              color: Colors.white,
                              fontSize: screen_height/20,
                              ),
                          ) : null ,
                    ),
                    SizedBox(width: 10),
                    Text(
                      username,
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
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => account_screen(userProfile: widget.userProfile)),
                    );
                  },
                  child: ListTile(
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
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => add_post_screen()),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.add_box,
                      color: Color(0xffBABABA),
                      size: screen_height / 25,
                    ),
                    title: Text(
                      'New Post',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontSize: screen_height / 35,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => add_post_screen()),
                    );
                  },
                  child: ListTile(
                    onTap: () async {
                      await CacheMethods.getCachedUserLoggedInState()
                          .then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  settings_screen(authState: widget.userProfile!.isAuthenticated)),
                        );
                      });
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
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // this will hide Drawer hamburger icon
        toolbarHeight: MediaQuery.of(context).size.height / 6,
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
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
                      'AutoW',
                      style: TextStyle(
                        fontSize: screen_height / 30,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.menu, color: Color(0xff121212)),
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
