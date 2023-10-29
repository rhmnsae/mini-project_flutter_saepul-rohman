import 'package:flutter/material.dart';
import 'package:simple_todo_list/Models/open_ai_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

class RecomendationAi extends StatelessWidget {
  final GptData gptResponseData;

  const RecomendationAi({super.key, required this.gptResponseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Iconsax.backward1,
            color: Color(0xFFB9B4C7),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Recommendations AI',
          style: GoogleFonts.firaCode(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFAF0E6),
          ),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF352F44),
      body: ListView.builder(
        itemCount: gptResponseData.choices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SelectableText(
              gptResponseData.choices[index].text,
              textAlign: TextAlign.justify,
              style: GoogleFonts.firaCode(
                fontSize: 17.0,
                color: const Color(0xFFB9B4C7),
              ),
            ),
          );
        },
      ),
    );
  }
}
