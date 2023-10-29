import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_todo_list/Pages/splash_animation.dart';

class SplashScreenController {
  // Fungsi untuk menampilkan tampilan splash selama 3 detik
  void splashTime(BuildContext context) {
    Timer(
      const Duration(milliseconds: 3000),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashAnimation()),
        );
      },
    );
  }
}
