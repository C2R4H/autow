import 'package:flutter/material.dart';

import '../drawer_screens/settings_screen.dart';
import '../bottomAppBar_screens/add_post_screen.dart';
import '../drawer_screens/account_screen.dart';

import '../../widgets/post_half_widget.dart';
import '../../widgets/profilePicture_widget.dart';
import '../../../backend/services/cache.dart';
import '../../../midend/user_profile.dart';

class home_screen extends StatefulWidget {
  UserProfile userProfile;
  home_screen(this.userProfile);
  @override
  home_screen_state createState() => home_screen_state();
}

class home_screen_state extends State<home_screen> {
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
                    profilePicture(
                      80,
                      widget.userProfile,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.userProfile.username!,
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
                      MaterialPageRoute(
                          builder: (context) =>
                              account_screen(widget.userProfile)),
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
                          builder: (context) =>
                              add_post_screen(widget.userProfile)),
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
                  onTap: () {},
                  child: ListTile(
                    onTap: () async {
                      await CacheMethods.getCachedUserLoggedInState()
                          .then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => settings_screen(
                                  authState:
                                      widget.userProfile.isAuthenticated)),
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
      body: CustomScrollView(
        slivers: [
          /*SliverAppBar(
            pinned: true,
            floating: true,
            snap:false,
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
          ),*/
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: Text('AutoW'),
            bottom: AppBar(
            automaticallyImplyLeading:
                false, // this will hide Drawer hamburger icon
              title: Container(
                width: double.infinity,
                height: 40,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color(0xff212121)),
                        prefixIcon: Icon(Icons.search,color: Color(0xff212121)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    post_half_widget(context),
                    post_half_widget(context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    post_half_widget(context),
                    post_half_widget(context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    post_half_widget(context),
                    post_half_widget(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
