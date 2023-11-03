import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  // Class untuk mengelola status login pengguna

  bool _isLoginTrue = false; // Variabel status login pengguna

  bool get isLoginTrue =>
      _isLoginTrue; // Getter untuk mendapatkan status login

  /// Metode untuk mengubah status login menjadi false
  void setLoginFalse() {
    _isLoginTrue = false; // Mengubah status login
    notifyListeners();
  }

  /// Metode untuk mengubah status login menjadi true (gagal)
  void setLoginTrue() {
    _isLoginTrue = true; // Mengubah status login
    notifyListeners();
  }
}
