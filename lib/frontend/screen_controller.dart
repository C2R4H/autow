import 'package:flutter/material.dart';

import '../backend/services/authentication.dart';
import '../backend/services/cache.dart';
import '../midend/user_profile.dart';

import 'screens/bottomAppBar_screens/home_screen.dart';
import 'screens/bottomAppBar_screens/favorites_screen.dart';
import 'screens/bottomAppBar_screens/add_post_screen.dart';
import 'screens/bottomAppBar_screens/messages_screen.dart';
import 'screens/bottomAppBar_screens/my_posts_screen.dart';

class screen_controller extends StatefulWidget {
  @override
  screen_controller_state createState() => screen_controller_state();
}

class screen_controller_state extends State<screen_controller> {

  AuthMethods authMethods = AuthMethods();
  UserProfile userProfile = UserProfile();

  final PageController _myPage = PageController(initialPage: 0);
  int _selectedIndex = 0;
  bool isAuthenticated = false;
  bool isLoading = false;

  checkState() async {
    bool? successful = false;
    setState((){
      isLoading=true;
    });
    await authMethods.isUserAuthenticated().then((value) async {
      isAuthenticated = value;
      CacheMethods.cacheUserLoggedInState(isAuthenticated);
      await userProfile.getData().then((value){
        successful = true;
      });
    });
    if(successful!){
      setState((){
        isLoading=false;
      });
    }
  }

  void _onItemTapped(int index){
    setState((){
      if(index!=2){
        _selectedIndex = index;
      }
    });
    if(index==0){
      _myPage.jumpToPage(0);
    } else if(index==1){
      _myPage.jumpToPage(1);
    } else if(index==2){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => add_post_screen()),
          );
    } else if(index==3){
      _myPage.jumpToPage(3);
    } else if(index==4){
      _myPage.jumpToPage(4);
    }
  }

  void initState() {
    checkState();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
        child: Center(
            child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
                ),
            ),
        ) : Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff121212),
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: const Color(0xff424242),
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
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: MediaQuery.of(context).size.height/50,
              ),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: MediaQuery.of(context).size.height/50,
              ),
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xffFF7171),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          ),
      body: PageView(
        controller: _myPage,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int) {
        },
        children: [
          home_screen(
              authState: isAuthenticated,
              userProfile: userProfile,
              ),
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
