import 'package:firebase_auth/firebase_auth.dart';
import 'cache.dart';

import '../../frontend/widgets/alertdialog.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> isUserAuthenticated() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  Future<bool> registerEmailAndPassword(
      String email, String password, context, String username) async {
    bool successful = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        User user = userCredential.user!;
        user.updateDisplayName(username);

        CacheMethods.cacheUserLoggedInState(true);
        CacheMethods.cacheUsernameState(username);
        CacheMethods.cacheUserEmailState(email);

        print(
            'Registered successfuly \: \n email: $email \n username: $username \n\n');
        successful = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code == 'weak-password') {
        print('weak-password');
        successful = false;
      } else if (e.code == 'email-already-in-use') {
        print('email-already-in-use');
        successful = false;
      }
      successful = false;
    } catch (e) {
      successful = false;
    }
    return successful;
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    bool successful = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = auth.currentUser; 
      String? username = user!.displayName.toString();

      await CacheMethods.cacheUserLoggedInState(true);
      await CacheMethods.cacheUsernameState(username);
      await CacheMethods.cacheUserEmailState(email);

      print(
          'Login successfuly \: \n email: $email \n username: $username \n\n');
      successful = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        successful = false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        successful = false;
      }
        successful = false;
    } catch (e) {
      successful = false;
      print(e);
    }
    return successful;
  }

  Future logout() async {
    try {
      CacheMethods.cacheUserLoggedInState(false);
      CacheMethods.cacheUsernameState("");
      CacheMethods.cacheUserEmailState("");
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
