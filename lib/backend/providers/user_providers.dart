import 'package:flutter/material.dart';
import 'package:instagram_clone/backend/authentication/auth_signup.dart';
import 'package:instagram_clone/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserDetails? _userDetails;
  UserDetails get getUserDetails => _userDetails!;
  final AuthSignUp authSignUp = AuthSignUp();
  Future<void> refreshUserDetails() async {
    UserDetails userDetails = await authSignUp.getUserDetails();
    _userDetails = userDetails;
    print(1);
    print(userDetails);
    notifyListeners();
  }
}
