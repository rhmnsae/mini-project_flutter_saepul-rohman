import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoginTrue = false;

  bool get isLoginTrue => _isLoginTrue;

  void setLoginFalse() {
    _isLoginTrue = false;
    notifyListeners();
  }

  void setLoginTrue() {
    _isLoginTrue = true;
    notifyListeners();
  }
}
