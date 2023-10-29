import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/todo_model.dart';
import 'package:simple_todo_list/Pages/Views/todo_page.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_category.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_date.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_description.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_subtitle.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_time.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_title.dart';
import 'package:simple_todo_list/Providers/update_todo_provider.dart';
import 'package:simple_todo_list/Utils/snackbar.dart';
import 'package:iconsax/iconsax.dart';

class EditTodo extends StatefulWidget {
  final Todo todolist;
  final Future<List<Todo>> todo;
  const EditTodo({required this.todo, required this.todolist, Key? key})
      : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  // Deklarasi variabel
  late String title;
  late String subtitle;
  late String description;
  late int prio;
  late int priority;
  late String date2;
  late String time;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Inisialisasi objek DatabaseHelper
    databaseHelper = DatabaseHelper();
    title = widget.todolist.title;
    subtitle = widget.todolist.subtitle;
    description = widget.todolist.description;
    prio = widget.todolist.priority!;
    date2 = widget.todolist.date2;
    time = widget.todolist.time;

    // Mengisi controller dengan data dari objek Todo
    titleController.text = title;
    subtitleController.text = subtitle;
    descriptionController.text = description;
    priority = prio;
    timeController.text = time;
    dateController.text = date2;
  }

  DatabaseHelper? databaseHelper;

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

                /// Save
                Consumer<UpdateTodoProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 25),
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            // Menampilkan Snackbar jika judul tidak diisi
                            Snackbar.showSnackBar(
                                context, 'Please fill in the title');
                          } else {
                            var now = DateTime.now();
                            var formatter = DateFormat('dd-MM-yyyy');
                            String formattedDate = formatter.format(now);

                            if (databaseHelper != null) {
                              // Mengupdate catatan
                              value.updateTodo(
                                Todo(
                                  id: widget.todolist.id,
                                  title: titleController.text.toString(),
                                  subtitle: subtitleController.text.toString(),
                                  description:
                                      descriptionController.text.toString(),
                                  priority: priority,
                                  date: formattedDate,
                                  date2: dateController.text.toString(),
                                  time: timeController.text.toString(),
                                ),
                                databaseHelper!,
                              );

                              // Menampilkan snackbar
                              Snackbar.showSnackBar(
                                  context, 'updated successfully');
                              // Kembali ke halaman TodoPage setelah catatan diperbarui
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TodoPage(),
                                ),
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF5C5470)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFFAF0E6)),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
