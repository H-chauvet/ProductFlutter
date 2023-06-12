import 'package:flutter/material.dart';

class User {
  final String username;

  User(this.username);
}

class UserProvider with ChangeNotifier {
  User _user = User('');

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
