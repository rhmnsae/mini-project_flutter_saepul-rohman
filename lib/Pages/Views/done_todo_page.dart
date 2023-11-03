// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Providers/done_todo_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

class DonePage extends StatefulWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoneTodoProvider>(context, listen: false).fetchCompletedTasks();
  }

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
          'Done Task',
          style: GoogleFonts.firaCode(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFAF0E6),
          ),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF352F44),

      /// Consumer untuk mendapatkan state dari DoneTodoProvider
      body: Consumer<DoneTodoProvider>(
        builder: (context, doneTasksModel, child) {
          final completedTasks = doneTasksModel.completedTasks;

          /// Tampilan ketika tidak ada tugas yang selesai
          return completedTasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.note_1,
                        color: Color(0xFF5C5470),
                        size: 45,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'No completed tasks',
                        style: GoogleFonts.firaCode(
                          fontSize: 18,
                          color: const Color(0xFF5C5470),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  /// Menampilkan daftar tugas yang telah selesai
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),

                      /// Widget Card untuk menampilkan tugas yang telah selesai
                      child: Card(
                        color: const Color(0xFF5C5470),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    task.title,
                                    style: GoogleFonts.firaCode(
                                      fontSize: 18,
                                      color: task.isCompleted
                                          ? const Color(0xFFB9B4C7)
                                          : const Color(0xFFFAF0E6),
                                      decoration: task.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      decorationThickness:
                                          task.isCompleted ? 7 : null,
                                      decorationColor: task.isCompleted
                                          ? const Color(0xFFFAF0E6)
                                          : null,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: task.priority == 1
                                        ? const Color(0xFFC70D3A)
                                        : task.priority == 2
                                            ? const Color(0xFFED5107)
                                            : const Color(0xFF1E5128),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  task.subtitle,
                                  style: GoogleFonts.firaCode(
                                    fontSize: 14,
                                    color: const Color(0xFFB9B4C7),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "created: ",
                                          style: GoogleFonts.firaCode(
                                            fontSize: 14,
                                            color: const Color(0xFFB9B4C7),
                                          ),
                                        ),
                                        Text(
                                          task.date,
                                          style: GoogleFonts.firaCode(
                                            fontSize: 14,
                                            color: const Color(0xFFB9B4C7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
