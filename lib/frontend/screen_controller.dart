import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../backend/services/authentication.dart';
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

  final PageController _myPage = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void _onItemTapped(int index,state) {
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
        MaterialPageRoute(builder: (context) => add_post_screen(state.userProfile)),
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
          } if (state is AuthBlocStateAuthenticated) {
            return screenController(context, _selectedIndex, _myPage,state,_onItemTapped);
          } if (state is AuthBlocStateUnaunthenticated) {
            return screenController(context, _selectedIndex, _myPage,state,_onItemTapped);
          }
          return Container();
        },
      ),
    );
    //return home_screen();
  }
}

Widget screenController(context,int _selectedIndex, PageController _myPage, state, _onItemTapped) {
  return Scaffold(
    bottomNavigationBar: Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onTap: (nr) {
          _onItemTapped(nr,state);
        },
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.add_box,color: Color(0xff51A0D5)),
            label: 'New Post',
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
            label: 'Posts',
            backgroundColor: const Color(0xff212121),
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.of(context).size.height / 55,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.of(context).size.height / 55,
        ),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
      ),
    ),
    body: PageView(
      controller: _myPage,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        home_screen(state.userProfile),
        favorites_screen(state.userProfile),
        add_post_screen(state.userProfile),
        messages_screen(state.userProfile),
        posts_screen(state.userProfile),
      ],
    ),
  );
}
