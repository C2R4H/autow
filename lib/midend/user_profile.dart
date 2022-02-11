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
      User? user = await authMethods.auth.currentUser;
      if (user != null) {
        String name = await user.displayName.toString();
        String email = await user.email.toString();
      }
    }
  return true;
  }
}
