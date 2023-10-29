import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/todo_model.dart';
import 'package:simple_todo_list/Pages/Views/add_todo_page.dart';
import 'package:simple_todo_list/Pages/Views/view_todo_page.dart';
import 'package:simple_todo_list/Pages/widgets/drawer.dart';
import 'package:simple_todo_list/Providers/todo_page_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:simple_todo_list/Pages/widgets/bottomsheet_ai.dart'
    as custom_bottom_sheet;

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // Inisialisasi objek DatabaseHelper
  DatabaseHelper? databaseHelper;
  // Deklarasi variabel yang akan berisi daftar catatan
  late Future<List<Todo>> todoList;

  @override
  void initState() {
    super.initState();
    // Inisialisasi objek DatabaseHelper
    databaseHelper = DatabaseHelper();
    // Memuat daftar catatan dari database
    loadData();
  }

  // Mengambil daftar catatan dari database
  loadData() async {
    todoList = databaseHelper!.getTodo();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        // Tindakan yang ingin dilakukan saat tombol kembali ditekan

        // Keluar dari aplikasi
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Simple To-Do',
            style: GoogleFonts.firaCode(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFAF0E6),
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Iconsax.menu_14,
                  color: Color(0xFFB9B4C7),
                ), // Ganti ikon menu sesuai kebutuhan
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          elevation: 4,
          centerTitle: true,
        ),

        backgroundColor: const Color(0xFF352F44),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            /// Category
            Consumer<PageTodoProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Menyaring catatan berdasarkan semua kategori
                        value.addFilter('all');
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: value.filter == 'all'
                              ? const Color(0xFF230338)
                              : const Color(0xFF5C5470),
                        ),
                        child: Center(
                          child: Text(
                            'All',
                            style: GoogleFonts.firaCode(
                              fontSize: 16,
                              color: const Color(0xFFB9B4C7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Menyaring catatan berdasarkan kategori tinggi (high)
                        value.addFilter('high');
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: value.filter == 'high'
                              ? const Color(0xFFC70D3A)
                              : const Color(0xFF5C5470),
                        ),
                        child: Center(
                          child: Text(
                            'High',
                            style: GoogleFonts.firaCode(
                              fontSize: 16,
                              color: const Color(0xFFB9B4C7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Menyaring catatan berdasarkan kategori sedang (medium)
                        value.addFilter('medium');
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: value.filter == 'medium'
                              ? const Color(0xFFED5107)
                              : const Color(0xFF5C5470),
                        ),
                        child: Center(
                          child: Text(
                            'Medium',
                            style: GoogleFonts.firaCode(
                              fontSize: 16,
                              color: const Color(0xFFB9B4C7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Menyaring catatan berdasarkan kategori rendah (low)
                        value.addFilter('low');
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: value.filter == 'low'
                              ? const Color(0xFF1E5128)
                              : const Color(0xFF5C5470),
                        ),
                        child: Center(
                          child: Text(
                            'Low',
                            style: GoogleFonts.firaCode(
                              fontSize: 16,
                              color: const Color(0xFFB9B4C7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(
              height: 10,
            ),

            /// Pilihan Kategori
            Consumer<PageTodoProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Expanded(
                  child: FutureBuilder(
                    future: todoList,
                    builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Iconsax.additem,
                                  size: 120,
                                  color: Color(0xFF5C5470),
                                ),
                                const SizedBox(height: 70),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70),
                                  child: Text(
                                    'No tasks have been added yet. When a task is complete, hold the task to mark it.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaCode(
                                      fontSize: 16,
                                      color: const Color(0xFF5C5470),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          );
                        } else {
                          List<Todo> filteredNotes = snapshot.data!;
                          if (value.filter == 'high') {
                            // Menyaring catatan berdasarkan kategori tinggi (high)
                            filteredNotes = snapshot.data!
                                .where((note) => note.priority == 1)
                                .toList();
                          } else if (value.filter == 'medium') {
                            // Menyaring catatan berdasarkan kategori sedang (medium)
                            filteredNotes = snapshot.data!
                                .where((note) => note.priority == 2)
                                .toList();
                          } else if (value.filter == 'low') {
                            // Menyaring catatan berdasarkan kategori rendah (low)
                            filteredNotes = snapshot.data!
                                .where((note) => note.priority == 3)
                                .toList();
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListView.builder(
                              itemCount: filteredNotes.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    var now = DateTime.now();
                                    var formatter = DateFormat('dd-MM-yyyy');
                                    String formattedDate =
                                        formatter.format(now);

                                    List<Todo>? snapData = filteredNotes;
                                    final data = Todo(
                                      id: filteredNotes[index].id,
                                      title:
                                          filteredNotes[index].title.toString(),
                                      subtitle: filteredNotes[index]
                                          .subtitle
                                          .toString(),
                                      description: filteredNotes[index]
                                          .description
                                          .toString(),
                                      priority: filteredNotes[index].priority,
                                      date: formattedDate,
                                      date2:
                                          filteredNotes[index].date2.toString(),
                                      time:
                                          filteredNotes[index].time.toString(),
                                    );

                                    // Navigasi ke halaman ViewTodo
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewTodo(
                                          snap: snapData,
                                          todo: todoList,
                                          todolist: data,
                                        ),
                                      ),
                                    );
                                  },
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      Todo todoToUpdate = filteredNotes[index];
                                      todoToUpdate.isCompleted = !todoToUpdate
                                          .isCompleted; // Membalik status tugas

                                      await databaseHelper?.update(
                                          todoToUpdate); // Menyimpan perubahan ke database

                                      setState(() {
                                        filteredNotes[index] =
                                            todoToUpdate; // Mengupdate tampilan saat status berubah
                                      });
                                    },
                                    child: Card(
                                      color: const Color(0xFF5C5470),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  filteredNotes[index]
                                                      .title
                                                      .toString(),
                                                  style: GoogleFonts.firaCode(
                                                    fontSize: 18,
                                                    color: filteredNotes[index]
                                                            .isCompleted
                                                        ? const Color(
                                                            0xFFB9B4C7)
                                                        : const Color(
                                                            0xFFFAF0E6),
                                                    decoration: filteredNotes[
                                                                index]
                                                            .isCompleted
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                    decorationThickness:
                                                        filteredNotes[index]
                                                                .isCompleted
                                                            ? 7
                                                            : null,
                                                    decorationColor:
                                                        filteredNotes[index]
                                                                .isCompleted
                                                            ? const Color(
                                                                0xFFFAF0E6)
                                                            : null,
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: filteredNotes[
                                                                  index]
                                                              .priority ==
                                                          1
                                                      ? const Color(0xFFC70D3A)
                                                      : filteredNotes[index]
                                                                  .priority ==
                                                              2
                                                          ? const Color(
                                                              0xFFED5107)
                                                          : const Color(
                                                              0xFF1E5128),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                filteredNotes[index]
                                                    .subtitle
                                                    .toString(),
                                                style: GoogleFonts.firaCode(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xFFB9B4C7),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "created: ",
                                                        style: GoogleFonts
                                                            .firaCode(
                                                          fontSize: 14,
                                                          color: const Color(
                                                              0xFFB9B4C7),
                                                        ),
                                                      ),
                                                      Text(
                                                        filteredNotes[index]
                                                            .date,
                                                        style: GoogleFonts
                                                            .firaCode(
                                                          fontSize: 14,
                                                          color: const Color(
                                                              0xFFB9B4C7),
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
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              },
            )
          ],
        ),

        /// Action Button
        floatingActionButton: SpeedDial(
          backgroundColor: const Color(0xFFB9B4C7),
          foregroundColor: const Color(0xFF5C5470),
          activeIcon: Icons.close,
          icon: Icons.add,
          curve: Curves.bounceIn,
          spacing: 10,
          overlayOpacity: 0.7,
          overlayColor: const Color(0xFF352F44),
          spaceBetweenChildren: 10,
          childPadding: const EdgeInsets.all(4),
          children: [
            SpeedDialChild(
              backgroundColor: const Color(0xFF5C5470),
              foregroundColor: const Color(0xFFB9B4C7),
              child: const Icon(Iconsax.note_add, color: Color(0xFFFAF0E6)),
              label: 'Add To-Do',
              labelBackgroundColor: const Color(0xFFB9B4C7),
              labelStyle: GoogleFonts.firaCode(
                fontSize: 15.0,
                color: const Color(0xFF352F44),
              ),
              onTap: () {
                // Navigasi ke halaman AddTodo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodo(
                      noteslist: todoList,
                    ),
                  ),
                );
              },
            ),
            SpeedDialChild(
              backgroundColor: const Color(0xFF5C5470),
              foregroundColor: const Color(0xFFB9B4C7),
              child: const Icon(Iconsax.star_1, color: Color(0xFFFAF0E6)),
              label: '7 Recommendations AI',
              labelBackgroundColor: const Color(0xFFB9B4C7),
              labelStyle: GoogleFonts.firaCode(
                fontSize: 15.0,
                color: const Color(0xFF352F44),
              ),
              onTap: () {
                custom_bottom_sheet.BottomSheet.showCustomBottomSheet(
                    context); // Memanggil bottom sheet di sini
              },
            ),
            // Tambahkan SpeedDialChild lain jika diperlukan
          ],
        ),
      ),
    );
  }
}
