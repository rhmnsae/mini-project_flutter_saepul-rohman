import 'package:flutter/material.dart';
import 'package:simple_todo_list/Models/todo_model.dart';
import 'package:simple_todo_list/Models/db_helper.dart';

class DoneTodoProvider extends ChangeNotifier {
  /// List _completedTasks akan menyimpan daftar tugas yang telah selesai
  late List<Todo> _completedTasks = [];

  /// Getter untuk mendapatkan akses ke daftar tugas yang telah selesai
  List<Todo> get completedTasks => _completedTasks;

  /// Mengambil tugas yang telah selesai dari databasae dan menyimpan ke _completedTasks
  Future<void> fetchCompletedTasks() async {
    _completedTasks = await DatabaseHelper().getCompletedTasks();
    notifyListeners();
  }

  /// Mengubah status selesai atau belum selesai dari tugas
  Future<void> toggleTaskStatus(int index) async {
    _completedTasks[index].isCompleted = !_completedTasks[index].isCompleted;
    await DatabaseHelper().update(_completedTasks[index]);
    notifyListeners();
  }

  void setCompletedTasks(List list) {}
}
