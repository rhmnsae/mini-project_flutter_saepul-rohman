import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionInput extends StatelessWidget {
  final TextEditingController descriptionController;

  const DescriptionInput({required this.descriptionController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          height: 270,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF5C5470),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            child: TextFormField(
              style: GoogleFonts.firaCode(
                  fontSize: 19, color: const Color(0xFFFAF0E6)),
              maxLines: 20,
              textInputAction: TextInputAction.newline,
              controller: descriptionController,
              cursorColor: const Color(0xFFB9B4C7),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Description',
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
