import 'package:flutter/foundation.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/todo_model.dart';

class UpdateTodoProvider with ChangeNotifier {
  int _priority = 1; // Nilai awal prioritas
  int get priority => _priority;

  /// Fungsi untuk mengatur prioritas
  void setPriority(int priority) {
    _priority = priority; // Mengubah nilai prioritas
    notifyListeners(); // Memberitahukan perubahan data
  }

  /// Fungsi untuk memperbarui data tugas (todo)
  void updateTodo(Todo todo, DatabaseHelper databaseHelper) {
    databaseHelper.update(todo); // Memanggil fungsi pembaruan di database
    notifyListeners(); // Memberitahukan perubahan data
  }
}
