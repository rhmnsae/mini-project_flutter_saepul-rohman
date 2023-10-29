// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_todo_list/Pages/Views/done_todo_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Database _database;
  String? _username = '';

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'db_todoapp_simple2.db'),
    );

    List<Map<String, dynamic>> users = await _database.query('Users');
    if (users.isNotEmpty) {
      setState(() {
        _username = users[0]['usrName'];
      });
    }
  }

  Future<void> _logout(BuildContext context) async {
    setState(() {
      _username =
          null; // Setelah logout, atur kembali username ke null atau nilai default
    });

    Navigator.pushReplacementNamed(context, '/login');
  }

  void _done(BuildContext context) {
    Navigator.pop(context); // Tutup drawer terlebih dahulu
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DonePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFB9B4C7),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                _username ?? 'No user', // Tampilkan username dari database
                style: GoogleFonts.firaCode(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFB9B4C7),
                ),
              ),
              accountEmail: Text(
                "Me@todo.com",
                style: GoogleFonts.firaCode(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFB9B4C7),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color(0xFFB9B4C7),
                child: Text(
                  _username != null && _username!.isNotEmpty
                      ? _username![0].toUpperCase()
                      : 'U',
                  style: GoogleFonts.firaCode(
                    fontSize: 40.0,
                    color: const Color(0xFF5C5470),
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF5C5470),
              ),
            ),
            ListTile(
              leading: const Icon(Iconsax.like_1),
              title: Text(
                'Done Task',
                style: GoogleFonts.firaCode(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5C5470),
                ),
              ),
              onTap: () {
                _done(context);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.logout_1),
              title: Text(
                'Logout',
                style: GoogleFonts.firaCode(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5C5470),
                ),
              ),
              onTap: () {
                _logout(context);
              },
            ),
            // Tambahkan ListTiles lainnya untuk item drawer yang diperlukan
          ],
        ),
      ),
    );
  }
}
