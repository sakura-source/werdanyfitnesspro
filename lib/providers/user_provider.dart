import 'package:flutter/material.dart';
import 'package:your_app/models/user.dart';

class UserProvider with ChangeNotifier {
  User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
