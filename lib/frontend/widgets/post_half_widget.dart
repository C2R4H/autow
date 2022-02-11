import 'package:flutter/material.dart';

import '../screens/post_screen.dart';

Widget post_half_widget(BuildContext context) {
  double screen_width = MediaQuery.of(context).size.width;
  double screen_height = MediaQuery.of(context).size.height;

  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => post_screen()),
            );
      },
      child: Container(
        width: screen_width / 2.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              height: screen_height / 5,
            ),
            SizedBox(height: screen_height / 80),
            Text(
              'Toyota Prius, 2010',
              style: TextStyle(
                fontSize: screen_height / 40,
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              '12 000 \$',
              style: TextStyle(
                fontSize: screen_height / 40,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screen_height / 70),
            Text(
              'Soroca',
              style: TextStyle(
                fontSize: screen_height / 40,
                color: Color(0xff424242),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screen_height / 70),
          ],
        ),
      ),
    ),
  );
}
