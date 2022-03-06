import 'package:firebase_auth/firebase_auth.dart';
import 'cache.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  String getMessageFromErrorCode(errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }

  Future<bool> isUserAuthenticated() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  Future<String> registerEmailAndPassword(
      String email, String password, String username) async {
    String success = "";
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        User user = auth.currentUser!;
        user.updateDisplayName(username);

        CacheMethods.cacheUserLoggedInState(true);
        CacheMethods.cacheUsernameState(username);
        CacheMethods.cacheUserEmailState(email);

        print(
            'Registered successfuly \: \n email: $email \n username: $username \n\n');
      success = "success";
      }
    } on FirebaseAuthException catch (e) {
      success = getMessageFromErrorCode(e.code);
    } catch (e) {
      success = "";
      print(e);
    }
    return success;
  }

  Future<String> loginWithEmailAndPassword(String email, String password) async {
    String success = "";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = auth.currentUser; 
      String? username = user!.displayName.toString();

      await CacheMethods.cacheUserLoggedInState(true);
      await CacheMethods.cacheUsernameState(username);
      await CacheMethods.cacheUserEmailState(email);

      print(
          'Login successfuly \: \n email: $email \n username: $username \n\n');
      success = "success";
    } on FirebaseAuthException catch (e) {
      success = getMessageFromErrorCode(e.code);
    } catch (e) {
      success = "";
      print(e);
    }
    return success;
  }

  Future logout() async {
    try {
      CacheMethods.cacheUserLoggedInState(false);
      CacheMethods.cacheUsernameState("");
      CacheMethods.cacheUserEmailState("");
      CacheMethods.cacheProfilePictureURL("");
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}


