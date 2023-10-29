import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeInput extends StatelessWidget {
  final TextEditingController timeController;

  const TimeInput({required this.timeController, Key? key}) : super(key: key);

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
            readOnly: true,
            style: GoogleFonts.firaCode(
              fontSize: 19,
              color: const Color(0xFFFAF0E6),
            ),
            controller: timeController,
            cursorColor: const Color(0xFFB9B4C7),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Time',
              hintStyle: const TextStyle(
                fontSize: 17,
                color: Color(0xFFB9B4C7),
              ),
              suffixIcon: Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Untuk menggeser ke kanan
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF352F44),
                              ),
                              buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((pickedTime) {
                        if (pickedTime != null) {
                          timeController.text = pickedTime.format(context);
                        }
                      });
                    },
                    child: const Icon(
                      Iconsax.clock,
                      color: Color(0xFFB9B4C7), // Sesuaikan warna ikon
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
