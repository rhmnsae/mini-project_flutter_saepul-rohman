import 'package:flutter/material.dart';
import 'package:simple_todo_list/Pages/auth/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/login': (context) => const LoginPage(),
    // Daftar rute lain di sini
  };
}
