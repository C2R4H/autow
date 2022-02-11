import 'package:flutter/material.dart';

import '../backend/services/authentication.dart';

import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/add_post_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/my_posts_screen.dart';

class screen_controller extends StatefulWidget {
  @override
  screen_controller_state createState() => screen_controller_state();
}

class screen_controller_state extends State<screen_controller> {

  AuthMethods authMethods = AuthMethods();

  PageController _myPage = PageController(initialPage: 0);
  int _selectedIndex = 0;


  void checkIfAuthenticated() async {
    print(await authMethods.isUserAuthenticated());
  }

  void _onItemTapped(int index){
    setState((){
      if(index!=2)
        _selectedIndex = index;
    });
    if(index==0)
      _myPage.jumpToPage(0);
    else if(index==1)
      _myPage.jumpToPage(1);
    else if(index==2){
      checkIfAuthenticated();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => add_post_screen()),
          );
    }
    else if(index==3)
      _myPage.jumpToPage(3);
    else if(index==4)
      _myPage.jumpToPage(4);
  }

  void initState(){
    checkIfAuthenticated();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: BottomAppBar(
        color: Color(0xff212121),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.grey),
              onPressed: () { 
                _myPage.jumpToPage(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_outline, color: Colors.grey),
              onPressed: () {
                _myPage.jumpToPage(1);
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => add_post_screen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.mail_outlined, color: Colors.grey),
              onPressed: () {
                _myPage.jumpToPage(3);
              },
            ),
            IconButton(
              icon: Icon(Icons.grid_on, color:  Colors.grey),
              onPressed: () {
                _myPage.jumpToPage(4);
              },
            ),
          ],
        ),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const  Color(0xff212121),
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: const Color(0xff212121),
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Favorites',
                backgroundColor: const Color(0xff212121),
                activeIcon: Icon(Icons.favorite),
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: 'Add post',
                backgroundColor: const Color(0xff212121),
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail_outlined),
                label: 'Messages',
                backgroundColor: const Color(0xff212121),
                activeIcon: Icon(Icons.mail),
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_on_outlined),
                label: 'My posts',
                backgroundColor: const Color(0xff212121),
                ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xffFF7171),
          onTap: _onItemTapped,
          ),
      body: PageView(
        controller: _myPage,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int) {
          print('Page has changed to index $int');
        },
        children: [
          home_screen(),
          favorites_screen(),
          add_post_screen(),
          messages_screen(),
          my_posts_screen(),
        ],
      ),
    );
    //return home_screen();
  }
}
