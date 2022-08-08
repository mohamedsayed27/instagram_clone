import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel;

  UserModel get getUser => _userModel!;
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _userModel = user;
    notifyListeners();
  }
}
