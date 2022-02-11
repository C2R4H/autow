import 'package:firebase_auth/firebase_auth.dart';
import 'cache.dart';

import '../../frontend/widgets/alertdialog.dart';

class AuthMethods {
  CacheMethods cacheMethods = CacheMethods();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool?> isUserAuthenticated() async {
    bool result = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        result = false;
      } else {
        result = true;
      }
    });
    return result;
  }

  Future<bool> registerEmailAndPassword(String email, String password,context) async {
    bool successful= false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential!=null){
        print(userCredential.toString());
        successful = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code == 'weak-password') {
        print('weak-password');
        successful = false;
      } else if (e.code == 'email-already-in-use') {
        print('email-already-in-use');
        successful= false;
      }
      successful= false;
    } catch (e) {
      successful = false;
    }
    return successful;
  }

  Future loginEmailAndPassowrd(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, 
              password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    try{
      return await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}
