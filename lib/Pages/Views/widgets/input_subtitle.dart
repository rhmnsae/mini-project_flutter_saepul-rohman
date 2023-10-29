import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitleInput extends StatelessWidget {
  final TextEditingController subtitleController;

  const SubtitleInput({required this.subtitleController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF5C5470),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            maxLines: 2,
            style: GoogleFonts.firaCode(
                fontSize: 19, color: const Color(0xFFFAF0E6)),
            controller: subtitleController,
            cursorColor: const Color(0xFFB9B4C7),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Subtitle',
              hintStyle: TextStyle(
                fontSize: 17,
                color: Color(0xFFB9B4C7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
