import 'package:flutter/foundation.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  int _priority = 1; // Prioritas default adalah 1 (misalnya, rendah)
  int get priority => _priority; // Getter untuk mendapatkan nilai prioritas

  void setPriority(int priority) {
    // Fungsi untuk mengatur nilai prioritas
    _priority = priority; // Mengatur nilai prioritas sesuai dengan yang dipilih
    notifyListeners(); // Memberitahukan perubahan nilai prioritas
  }

  void addTodo(Todo todo, DatabaseHelper databaseHelper) {
    // Fungsi untuk menambahkan tugas ke database
    databaseHelper
        .insert(todo); // Memanggil method 'insert' pada databaseHelper
    notifyListeners(); // Memberitahukan perubahan data
  }
}
