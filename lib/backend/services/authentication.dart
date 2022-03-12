import 'package:firebase_auth/firebase_auth.dart';
import 'cache.dart';
import 'firestore_database.dart';

class AuthMethods {
  FirestoreDatabaseMethods _firestoreDatabaseMethods =
      FirestoreDatabaseMethods();
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

  Future<String> sendPasswordResetEmail(String email) async {
    String success = "";
    try {
      await auth.sendPasswordResetEmail(email: email);
      success = "success";
    } on FirebaseAuthException catch (e) {
      success = getMessageFromErrorCode(e.code);
    } catch (e) {
      success = e.toString();
    }
    return success;
  }

  Future<String> updateAuthUsername(String username) async {
    String success = "Username Error";
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.updateDisplayName(username);
      success = 'success';
    }
    return success;
  }

  Future<String> updatePassword(String password, String newPassword) async {
    String success = "";
    User? user = FirebaseAuth.instance.currentUser;
    final cred =
        EmailAuthProvider.credential(email: user!.email!, password: password);

    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        success = 'success';
      }).catchError((error) {
        success = error.toString();
      });
    }).catchError((err) {
        success = err.toString();
    });


    return success;
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

        Map<String, dynamic> userDataMap = {
          "id": user.uid,
          "name": username,
          "email": email,
          "picture": "",
          "registered": DateTime.now().millisecondsSinceEpoch,
        };

        _firestoreDatabaseMethods.uploadUser(userDataMap, user.uid);

        CacheMethods.cacheUserLoggedInState(true);
        CacheMethods.cacheUsernameState(username);
        CacheMethods.cacheUserEmailState(email);
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

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    String success = "";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = auth.currentUser;
      String? username = user!.displayName.toString();

      await CacheMethods.cacheUserLoggedInState(true);
      await CacheMethods.cacheUsernameState(username);
      await CacheMethods.cacheUserEmailState(email);
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
