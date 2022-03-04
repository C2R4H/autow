import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../backend/services/authentication.dart';
import '../midend/user_profile.dart';
import '../midend/bloc/auth_bloc/auth_bloc.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      if (index != 2) {
        _selectedIndex = index;
      }
    });
    if (index == 0) {
      _myPage.jumpToPage(0);
    } else if (index == 1) {
      _myPage.jumpToPage(1);
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => add_post_screen()),
      );
    } else if (index == 3) {
      _myPage.jumpToPage(3);
    } else if (index == 4) {
      _myPage.jumpToPage(4);
    }
  }

  final AuthBloc _authBloc = AuthBloc();

  void initState() {
    _authBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _authBloc,
      child: BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (context, state) {
          if (state is AuthBlocStateLoading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ),
            );
          } else if (state is AuthBlocStateAuthenticated) {
            print('is authenticated');
            return Scaffold(
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
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xffFF7171),
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
              ),
              body: PageView(
                controller: _myPage,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (int) {},
                children: [
                  home_screen(
                    userProfile: state.userProfile
                  ),
                  favorites_screen(),
                  add_post_screen(),
                  messages_screen(),
                  my_posts_screen(),
                ],
              ),
            );
          } else if (state is AuthBlocStateUnaunthenticated) {
            print('is not authenticated');
            return Scaffold(
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
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xffFF7171),
                unselectedItemColor: Colors.red,
                onTap: _onItemTapped,
              ),
              body: PageView(
                controller: _myPage,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (int) {},
                children: [
                  home_screen(
                    userProfile: state.userProfile
                  ),
                  favorites_screen(),
                  add_post_screen(),
                  messages_screen(),
                  my_posts_screen(),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
    //return home_screen();
  }
}
