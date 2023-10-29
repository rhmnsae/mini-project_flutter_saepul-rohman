import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/todo_model.dart';
import 'package:simple_todo_list/Pages/Views/edit_todo_page.dart';
import 'package:simple_todo_list/Pages/Views/todo_page.dart';
import 'package:simple_todo_list/Providers/delete_todo_provider.dart';
import 'package:simple_todo_list/Utils/snackbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTodo extends StatefulWidget {
  final List<Todo>? snap;
  final Future<List<Todo>> todo;
  final Todo todolist;
  const ViewTodo({
    required this.snap,
    required this.todo,
    required this.todolist,
    Key? key,
  }) : super(key: key);

  @override
  State<ViewTodo> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewTodo> {
  DatabaseHelper? databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('build'); // Output debug jika dalam mode debug
    }
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Mencegah pengubahan ukuran saat keyboard muncul
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
        actions: [
          /// Delete
          Consumer<DeleteTodoProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xFFB9B4C7), 
                        title: Text(
                          'Delete Task',
                          style: GoogleFonts.firaCode(
                            fontSize: 23,
                            color: const Color(0xFF5C5470),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to delete this task?',
                          style: GoogleFonts.firaCode(
                            fontSize: 15,
                            color: const Color(0xFF5C5470),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.firaCode(
                                fontSize: 16,
                                color: const Color(0xFF5C5470),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Delete',
                              style: GoogleFonts.firaCode(
                                fontSize: 16,
                                color: const Color(0xFF5C5470),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              if (kDebugMode) {
                                print('icon di dalam');
                              }
                              value.deleteTodo(
                                  databaseHelper!, widget.todolist.id!);
                              Snackbar.showSnackBar(
                                  context, 'Deleted successfully');
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TodoPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Iconsax.trush_square,
                  color: Color(0xFFB9B4C7),
                ),
              );
            },
          ),

          /// Edit
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodo(
                    todo: widget.todo,
                    todolist: widget.todolist,
                  ),
                ),
              ); // Pindah ke halaman edit ketika tombol edit ditekan
            },
            icon: const Icon(
              Iconsax.edit,
              color: Color(0xFFB9B4C7),
            ), // Tombol ikon edit
          )
        ],
        elevation: 4,
      ),
      backgroundColor: const Color(0xFF352F44),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),

              /// Title
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFF5C5470), // Warna latar belakang abu-abu transparan
                    borderRadius: BorderRadius.circular(
                        8), // Membuat sudut elemen melengkung
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      widget.todolist.title,
                      style: GoogleFonts.firaCode(
                          fontSize: 19, color: const Color(0xFFFAF0E6)),
                    ),
                  ),
                ),
              ),

              /// Subtitle
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C5470),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 11),
                    child: Text(
                      widget.todolist.subtitle.isNotEmpty
                          ? widget.todolist.subtitle
                          : 'Empty', // Ganti dengan teks placeholder
                      style: GoogleFonts.firaCode(
                        fontSize: 19,
                        color: widget.todolist.subtitle.isNotEmpty
                            ? const Color(
                                0xFFFAF0E6) // Warna teks saat ada teks
                            : const Color(0xFFB9B4C7), // Warna teks placeholder
                      ),
                    ),
                  ),
                ),
              ),

              /// Kategori
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 15, // Ukuran radius avatar lingkaran
                        backgroundColor: widget.todolist.priority == 1
                            ? const Color(0xFFC70D3A)
                            : widget.todolist.priority == 2
                                ? const Color(0xFFED5107)
                                : const Color(0xFF1E5128)),
                  ],
                ),
              ),

              /// Deskripsi
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  height: 270,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C5470),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    child: Text(
                      widget.todolist.description.isNotEmpty
                          ? widget.todolist.description
                          : 'Empty', // Ganti dengan teks placeholder
                      style: GoogleFonts.firaCode(
                        fontSize: 19,
                        color: widget.todolist.description.isNotEmpty
                            ? const Color(
                                0xFFFAF0E6) // Warna teks saat ada teks
                            : const Color(0xFFB9B4C7), // Warna teks placeholder
                      ),
                    ),
                  ),
                ),
              ),

              /// Tampilkan Tanggal yang Dipilih
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C5470),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.todolist.date2.isNotEmpty
                              ? widget.todolist.date2
                              : 'Empty', // Ganti dengan teks placeholder
                          style: GoogleFonts.firaCode(
                            fontSize: 19,
                            color: widget.todolist.date2.isNotEmpty
                                ? const Color(
                                    0xFFFAF0E6) // Warna teks saat ada tanggal
                                : const Color(
                                    0xFFB9B4C7), // Warna teks placeholder
                          ),
                        ),
                        const Icon(
                          Iconsax.calendar_1, color: Color(0xFFB9B4C7), //
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Tampilkan Waktu yang Dipilih
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C5470),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.todolist.time.isNotEmpty
                              ? widget.todolist.time
                              : 'Empty', // Ganti dengan teks placeholder
                          style: GoogleFonts.firaCode(
                            fontSize: 19,
                            color: widget.todolist.time.isNotEmpty
                                ? const Color(
                                    0xFFFAF0E6) // Warna teks saat ada waktu
                                : const Color(
                                    0xFFB9B4C7), // Warna teks placeholder
                          ),
                        ),
                        const Icon(
                          Iconsax.clock,
                          color: Color(0xFFB9B4C7),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
