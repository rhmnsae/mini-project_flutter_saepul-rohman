import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleInput extends StatelessWidget {
  final TextEditingController titleController;

  const TitleInput({required this.titleController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF5C5470),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: TextFormField(
            textInputAction: TextInputAction.newline,
            style: GoogleFonts.firaCode(
                fontSize: 19, color: const Color(0xFFFAF0E6)),
            controller: titleController,
            cursorColor: const Color(0xFFB9B4C7),
            decoration: InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
              hintStyle: GoogleFonts.firaCode(
                fontSize: 17,
                color: const Color(0xFFB9B4C7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
