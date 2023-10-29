import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Snackbar {
  // Metode untuk menampilkan Snackbar
  static void showSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFFB9B4C7),
        content: Text(
          title,
          style: GoogleFonts.firaCode(
              fontSize: 20, color: const Color(0xFF5C5470)),
        ),
      ),
    );
  }
}
