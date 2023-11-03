import 'package:flutter/foundation.dart';

class PageTodoProvider with ChangeNotifier {
  String _filter = 'all';

  // Getter untuk filter
  get filter => _filter;

  /// Fungsi untuk mengubah filter
  void addFilter(String val) {
    _filter = val; // Mengganti nilai filter dengan nilai yang diberikan
    notifyListeners(); // Memberitahukan perubahan data
  }
}
