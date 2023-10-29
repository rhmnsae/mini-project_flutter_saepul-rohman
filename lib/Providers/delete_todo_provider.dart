import 'package:flutter/foundation.dart';
import 'package:simple_todo_list/Models/db_helper.dart';

class DeleteTodoProvider with ChangeNotifier {
  Future<void> deleteTodo(DatabaseHelper databaseHelper, int id) async {
    // Fungsi untuk menghapus tugas berdasarkan ID
    await databaseHelper.delete(
        id); // Memanggil metode 'delete' pada databaseHelper dengan ID yang diberikan
    notifyListeners(); // Memberitahukan perubahan data
  }
}
