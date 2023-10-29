// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_todo_list/Pages/Views/rcmnd_ai_todo_page.dart';
import 'package:simple_todo_list/services/rcmnd_ai.dart';

class BottomSheet {
  static void showCustomBottomSheet(BuildContext context) {
    TextEditingController textController = TextEditingController();

    bool isLoading = false; // State to manage loading

    final currentContext = context; // Capture the context

    showModalBottomSheet(
      backgroundColor: const Color(0xFFB9B4C7),
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: SizedBox(
                height: 90,
                child: ListTile(
                  leading: const Icon(Iconsax.star_1, color: Color(0xFF352F44)),
                  title: TextField(
                    style: GoogleFonts.firaCode(
                      fontSize: 19,
                      color: const Color(0xFF352F44),
                    ),
                    controller: textController,
                    cursorColor: const Color(0xFF352F44),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '7 Recommendations AI',
                      hintStyle: GoogleFonts.firaCode(
                        fontSize: 17,
                        color: const Color(0xFF352F44),
                      ),
                    ),
                    autofocus: true,
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      try {
                        if (textController.text.isEmpty) {
                          // Jika input kosong, tampilkan Dialog
                          showDialog(
                            context: sheetContext,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                backgroundColor: const Color(0xFFB9B4C7),
                                title: Text(
                                  'Warning',
                                  style: GoogleFonts.firaCode(
                                    fontSize: 23,
                                    color: const Color(0xFF5C5470),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  'Please enter a recommendation',
                                  style: GoogleFonts.firaCode(
                                    fontSize: 15,
                                    color: const Color(0xFF5C5470),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.firaCode(
                                        fontSize: 16,
                                        color: const Color(0xFF5C5470),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          setState(() {
                            isLoading = true; // Set loading state to true
                          });
                          final result = await RecommendationService
                              .getTugasRecomendations(
                            tugas: textController.text,
                          );
                          setState(() {
                            isLoading = false; // Set loading state to false
                          });
                          Navigator.of(sheetContext).pop();
                          Navigator.of(currentContext).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return RecomendationAi(
                                  key: UniqueKey(),
                                  gptResponseData: result,
                                );
                              },
                            ),
                          );
                        }
                      } catch (e) {
                        showDialog(
                          context: sheetContext,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              backgroundColor: const Color(0xFFB9B4C7),
                              title: Text(
                                'Error',
                                style: GoogleFonts.firaCode(
                                  fontSize: 25,
                                  color: const Color(0xFF5C5470),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'Failed to get recommendations. Please try again.',
                                style: GoogleFonts.firaCode(
                                  fontSize: 15,
                                  color: const Color(0xFF5C5470),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: GoogleFonts.firaCode(
                                      fontSize: 16,
                                      color: const Color(0xFF5C5470),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    icon: isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF352F44)),
                          ) // Show loading indicator
                        : const Icon(Iconsax.send_1),
                    color: const Color(0xFF352F44),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
