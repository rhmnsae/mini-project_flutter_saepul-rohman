import 'package:flutter/material.dart';
import 'package:simple_todo_list/Models/todo_model.dart';
import 'package:simple_todo_list/Models/db_helper.dart';

class DoneTodoProvider extends ChangeNotifier {
  late List<Todo> _completedTasks = [];

  List<Todo> get completedTasks => _completedTasks;

  Future<void> fetchCompletedTasks() async {
    _completedTasks = await DatabaseHelper().getCompletedTasks();
    notifyListeners();
  }

  Future<void> toggleTaskStatus(int index) async {
    _completedTasks[index].isCompleted = !_completedTasks[index].isCompleted;
    await DatabaseHelper().update(_completedTasks[index]);
    notifyListeners();
  }

  void setCompletedTasks(List list) {}
}
