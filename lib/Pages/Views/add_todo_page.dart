import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/todo_model.dart';
import 'package:simple_todo_list/Pages/Views/todo_page.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_date.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_description.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_subtitle.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_time.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_category.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_title.dart';
import 'package:simple_todo_list/Providers/add_todo_provider.dart';
import 'package:simple_todo_list/Utils/snackbar.dart';
import 'package:iconsax/iconsax.dart';

import 'package:google_fonts/google_fonts.dart';

/// Kelas untuk menambahkan tugas baru
class AddTodo extends StatefulWidget {
  final Future<List<Todo>> noteslist;
  const AddTodo({required this.noteslist, Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  // Controllers untuk input
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  int priority = 1; // Prioritas default

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 43, 58),
        leading: IconButton(
          icon: const Icon(
            Iconsax.backward1,
            color: Color(0xFFB9B4C7),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 4,
      ),
      backgroundColor: const Color(0xFF352F44),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),

              /// Input Title
              TitleInput(titleController: titleController),

              /// Input Subtitle
              SubtitleInput(subtitleController: subtitleController),

              /// Input Kategori
              const CategoryInput(),

              /// Input Deskripsi
              DescriptionInput(descriptionController: descriptionController),

              /// Input Tanggal
              DateInput(dateController: dateController),

              /// Input Waktu
              TimeInput(timeController: timeController),

              /// Tombol Simpan
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 25),

                /// Menggunakan Consumer dari provider untuk mendapatkan state dari TodoProvider
                child: Consumer<TodoProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('inside add todo');
                        }
                        if (titleController.text.isEmpty) {
                          // Menampilkan Snackbar jika judul tidak diisi
                          Snackbar.showSnackBar(
                              context, 'Please fill in the title');
                        } else {
                          // menyimpan waktu pada saat ini
                          var now = DateTime.now();
                          var formatter = DateFormat('dd-MM-yyyy');
                          String formattedDate = formatter.format(now);

                          /// Menambahkan tugas baru ke daftar tugas
                          value.addTodo(
                            Todo(
                              title: titleController.text.toString(),
                              subtitle: subtitleController.text.toString(),
                              description:
                                  descriptionController.text.toString(),
                              priority: value.priority,
                              date: formattedDate,
                              date2: dateController.text.toString(),
                              time: timeController.text.toString(),
                            ),
                            databaseHelper,
                          );

                          // Setelah tugas ditambahkan ada snackbar
                          Snackbar.showSnackBar(context, 'Added successfully');
                          // Setelah tugas ditambahkan, pindahkan ke halaman TodoPage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TodoPage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5C5470),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.firaCode(
                          fontSize: 18,
                          color: const Color(0xFFFAF0E6),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
