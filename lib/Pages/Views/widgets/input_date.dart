import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget untuk input tanggal yang berisi field untuk memilih tanggal
class DateInput extends StatelessWidget {
  final TextEditingController
      dateController; // Controller untuk mengelola input tanggal

  const DateInput({required this.dateController, Key? key}) : super(key: key);

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

            /// Menghubungkan controller untuk input
            controller: dateController,
            cursorColor: const Color(0xFFB9B4C7),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Date',
              hintStyle: GoogleFonts.firaCode(
                fontSize: 17,
                color: const Color(0xFFB9B4C7),
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      /// Menampilkan pemilih tanggal ketika ikon kalender ditekan.
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime
                            .now(), //tanggal yang bisa di input (sekarang
                        lastDate: DateTime(2050), //sampai 2050
                        initialDatePickerMode:
                            DatePickerMode.day, // Menetapkan mode awal ke 'day'
                        selectableDayPredicate: (DateTime dateTime) {
                          return true; // Mengembalikan true untuk memungkinkan semua hari dipilih
                        },
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
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          dateController.text =
                              // Format tanggal dan masukkan ke dalam input.
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                        }
                      });
                    },
                    child: const Icon(
                      Iconsax.calendar_1,
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
