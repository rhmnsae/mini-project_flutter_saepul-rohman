import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  bool _isSignUpSuccess = false;

  bool get isSignUpSuccess => _isSignUpSuccess;

  void setSignUpSuccess() {
    _isSignUpSuccess = true;
    notifyListeners();
  }
}
