import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_todo_list/Pages/auth/login_page.dart';

class SplashAnimationController {
  // Fungsi untuk menampilkan tampilan splash selama 4 detik
  void splashTime(BuildContext context) {
    Timer(
      const Duration(milliseconds: 4000),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
    );
  }
}
