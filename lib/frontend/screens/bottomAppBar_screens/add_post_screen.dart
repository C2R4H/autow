import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/notLogged_widget.dart';
import '../../../midend/user_profile.dart';
import '../../../midend/bloc/newPost_bloc/newPost_bloc.dart';

import 'add_post_screens/brands.dart';
import 'add_post_screens/automobiles.dart';

class add_post_screen extends StatefulWidget {
  UserProfile userProfile;
  add_post_screen(this.userProfile);
  @override
  add_post_screen_state createState() => add_post_screen_state();
}

class add_post_screen_state extends State<add_post_screen> {
  NewPostBloc _newPostBloc = NewPostBloc();

  void initState() {
    _newPostBloc.add(NewPostEventLoadData());
    super.initState();
  }

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
      body: widget.userProfile.isAuthenticated!
          ? BlocProvider(
              create: (context) => _newPostBloc,
              child: Container(
                child: listViewPost(_newPostBloc,context),
              ),
            )
          : userNotLogged_widget(context, screen_width, screen_height,
              information_text, Icons.add_box),
    );
  }
}

Widget listViewPost(_newPostBloc,context) {
  return BlocBuilder<NewPostBloc, NewPostState>(
    bloc: _newPostBloc,
    builder: (context, state) {
      print(state);
      return ListView(
        children: [
          ListTile(
            leading: Text(
              'Brand*',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            tileColor: Color(0xff121212),
            shape: Border(
              top: BorderSide(
                width: 1,
                color: Color(0xff212121),
              ),
              bottom: BorderSide(
                width: 1,
                color: Color(0xff212121),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => brands(_newPostBloc)),
              );
            },
          ),
          listProp("Model", "text", _newPostBloc, automobiles(state.choosedBrand,state.choosedBrandName,_newPostBloc),context),
        ],
      );
    },
  );
}

Widget listProp(String leading, trailingText, _newPostBloc, Widget screen,context) {
  return BlocBuilder<NewPostBloc, NewPostState>(
      bloc: _newPostBloc,
      builder: (context, state) {
        return ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          leading: Text(
            '$leading*',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Color(0xffBABABA),
            ),
          ),
          tileColor: Color(0xff121212),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          shape: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xff212121),
            ),
          ),
        );
      });
}
