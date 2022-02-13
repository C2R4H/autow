import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../backend/services/cache.dart';
import '../backend/services/authentication.dart';

class UserProfile {
  AuthMethods authMethods = AuthMethods();

  String? username = "";
  String? email = "";

  Future<bool?> getData() async {
    username = await CacheMethods.getCachedUsernameState();
    email = await CacheMethods.getCachedUserEmailState();
    if (username == "") {
      User? user = authMethods.auth.currentUser;
      if (user != null) {
        username = user.displayName.toString();
        email = user.email.toString();
      }else{
        username = "AutoW";
        email = "AutoW";
      }
    }
  return true;
  }
}
