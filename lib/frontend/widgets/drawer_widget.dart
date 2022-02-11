import 'package:flutter/material.dart';

Widget drawer_widget(double screen_height, double screen_width) {
  return Drawer(
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
                  'Stratulat Cristian',
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
            leading: Icon(
              Icons.home,
              color: Color(0xffBABABA),
              size: screen_width / 15,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: screen_width / 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite_outlined,
              color: Color(0xffBABABA),
              size: screen_width / 15,
            ),
            title: Text(
              'Favorites',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: screen_width / 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.add_box,
              color: Color(0xffBABABA),
              size: screen_width / 15,
            ),
            title: Text(
              'Add a post',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: screen_width / 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.mail_outlined,
              color: Color(0xffBABABA),
              size: screen_width / 15,
            ),
            title: Text(
              'Messages',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: screen_width / 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.grid_on,
              color: Color(0xffBABABA),
              size: screen_width / 15,
            ),
            title: Text(
              'My posts',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: screen_width / 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
