import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Pages/splash_screen.dart';
import 'package:simple_todo_list/Providers/add_todo_provider.dart';
import 'package:simple_todo_list/Providers/delete_todo_provider.dart';
import 'package:simple_todo_list/Providers/done_todo_provider.dart';
import 'package:simple_todo_list/Providers/login_provider.dart';
import 'package:simple_todo_list/Providers/signup_provider.dart';
import 'package:simple_todo_list/Providers/todo_page_provider.dart';
import 'package:simple_todo_list/Providers/update_todo_provider.dart';
import 'package:simple_todo_list/routes/route.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Menyediakan instance dari berbagai provider yang diperlukan
        ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider()),
        ChangeNotifierProvider<PageTodoProvider>(
            create: (_) => PageTodoProvider()),
        ChangeNotifierProvider<DeleteTodoProvider>(
            create: (_) => DeleteTodoProvider()),
        ChangeNotifierProvider<UpdateTodoProvider>(
            create: (_) => UpdateTodoProvider()),
        ChangeNotifierProvider<DoneTodoProvider>(
            create: (_) => DoneTodoProvider()),
        ChangeNotifierProvider<LoginProvider>(
            create: (_) => LoginProvider()),
        ChangeNotifierProvider<SignUpProvider>(
            create: (_) => SignUpProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 47, 43, 58),
          ),
        ),
        routes: getAppRoutes(),
        initialRoute: '/',
        home: const SplashScreen(),
      ),
    );
  }
}
