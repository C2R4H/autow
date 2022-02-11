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
        home: screen_controller(),
        );
  }
}

