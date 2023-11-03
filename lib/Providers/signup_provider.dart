import 'package:flutter/material.dart';

/// Class untuk mengelola status berhasil daftar
class SignUpProvider with ChangeNotifier {

  bool _isSignUpSuccess = false; // Variabel status berhasil daftar

  bool get isSignUpSuccess => _isSignUpSuccess; // Getter untuk mendapatkan status keberhasilan pendaftaran

  void setSignUpSuccess() {
    _isSignUpSuccess = true; // Mengubah status keberhasilan pendaftaran
    notifyListeners();
  }
}
