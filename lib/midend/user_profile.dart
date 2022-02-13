import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../backend/services/cache.dart';
import '../backend/services/authentication.dart';

class UserProfile {
  AuthMethods authMethods = AuthMethods();

  String? username = "";
  String? email = "";
  String? profileImage = "";

  Future<bool?> getData() async {
    username = await CacheMethods.getCachedUsernameState();
    email = await CacheMethods.getCachedUserEmailState();
    profileImage = await CacheMethods.getCachedProfilePictureURL();
    if (username == "" || email == "" || profileImage == "") {
      User? user = authMethods.auth.currentUser;
      if (user != null) {
        username = user.displayName.toString();
        email = user.email.toString();
        if(user.photoURL.toString()!="null"){
          profileImage = user.photoURL.toString();
        }
      }else{
        username = "AutoW";
        email = "AutoW";
      }
    }
  return true;
  }

  Future uploadProfilePictureURL(String downloadURL) async {
    User? user = authMethods.auth.currentUser;
    await CacheMethods.cacheProfilePictureURL(downloadURL);
    await user!.updatePhotoURL(downloadURL);
    profileImage = downloadURL;
  }
}
