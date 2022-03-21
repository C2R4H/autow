import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'frontend/screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AutoW());
}

class AutoW extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        /*theme: ThemeData.light().copyWith(
            ),*/
        theme: ThemeData.dark().copyWith(
            primaryColor: const Color(0xff212121),
            accentColor: const Color(0xff51A05D),
            canvasColor: const Color(0xff121212),
            appBarTheme: AppBarTheme(
                backgroundColor: const Color(0xff121212),
                ),
            scaffoldBackgroundColor: Colors.black,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: const Color(0xff121212),
                ),
            ),
        home: screen_controller(),
        );
  }
}

