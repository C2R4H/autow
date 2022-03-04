import 'package:firebase_auth/firebase_auth.dart';

import '../backend/services/cache.dart';
import '../backend/services/authentication.dart';

class UserProfile {
  AuthMethods authMethods = AuthMethods();

  bool? isAuthenticated = false;
  String? username = "AutoW";
  String? email = "AutoW";
  String? profileImage = "";

  Future<bool?> getData() async {
    username = await CacheMethods.getCachedUsernameState();
    email = await CacheMethods.getCachedUserEmailState();
    profileImage = await CacheMethods.getCachedProfilePictureURL();
    isAuthenticated = await CacheMethods.getCachedUserLoggedInState();
    if (username == null || email == null || profileImage == "" || isAuthenticated == null  || profileImage == null ) {
      User? user = authMethods.auth.currentUser;
      if (user != null) {
        isAuthenticated = true;
        if(user.displayName!=null){
          username = user.displayName.toString();
        }
        if(user.displayName!=null){
          email = user.email.toString();
        }
        if(user.photoURL.toString()!="null"){
          profileImage = user.photoURL.toString();
        }
      }else{
        isAuthenticated = false;
        username = "AutoW";
        email = "AutoW";
        profileImage = "";
      }
    }
    print(isAuthenticated);
    print(username);
    print(email);
    print(profileImage);
  return true;
  }

  Future uploadProfilePictureURL(String downloadURL) async {
    User? user = authMethods.auth.currentUser;
    await CacheMethods.cacheProfilePictureURL(downloadURL);
    await user!.updatePhotoURL(downloadURL);
    profileImage = downloadURL;
  }
}
