// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/user_model.dart';
import 'package:simple_todo_list/Pages/Views/todo_page.dart';
import 'package:simple_todo_list/Pages/auth/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Providers/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool isVisible = false;

  // mengaksses fungsi-fungsi database
  final db = DatabaseHelper();

  // mengidentifikasi form
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF352F44),
      body: ChangeNotifierProvider(
        create: (context) => LoginProvider(), // Inisialisasi provider
        child: Consumer<LoginProvider>(
          builder: (context, provider, child) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Login",
                            style: GoogleFonts.firaCode(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFB9B4C7),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        /// Input field untuk username
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFF5C5470)),
                          child: TextFormField(
                            style: GoogleFonts.firaCode(
                              fontSize: 19,
                              color: const Color(0xFFFAF0E6),
                            ),
                            controller: username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "username is required";
                              }
                              return null;
                            },
                            cursorColor: const Color(0xFFB9B4C7),
                            decoration: InputDecoration(
                              icon: const Icon(
                                Iconsax.user,
                                color: Color(0xFFB9B4C7),
                              ),
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: GoogleFonts.firaCode(
                                fontSize: 17,
                                color: const Color(0xFFB9B4C7),
                              ),
                            ),
                          ),
                        ),

                        /// Input field untuk password
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFF5C5470)),
                          child: TextFormField(
                            style: GoogleFonts.firaCode(
                              fontSize: 19,
                              color: const Color(0xFFFAF0E6),
                            ),
                            controller: password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              }
                              return null;
                            },
                            cursorColor: const Color(0xFFB9B4C7),
                            obscureText: !isVisible,
                            decoration: InputDecoration(
                              icon: const Icon(
                                Iconsax.lock,
                                color: Color(0xFFB9B4C7),
                              ),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: GoogleFonts.firaCode(
                                fontSize: 17,
                                color: const Color(0xFFB9B4C7),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible ? Iconsax.eye : Iconsax.eye_slash,
                                  color: const Color(0xFFB9B4C7),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        /// Login Button
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFB9B4C7)),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // Menggunakan fungsi login dengan meneruskan provider
                                login(context.read<LoginProvider>());
                              }
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.firaCode(
                                color: const Color(0xFF5C5470),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        /// sign up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.firaCode(
                                color: const Color(0xFFB9B4C7),
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                //Navigasi ke halaman sign-up
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.firaCode(
                                  color: const Color(0xFFFAF0E6),
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                        if (provider.isLoginTrue)
                          Text(
                            "Username or password is incorrect",
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFFFAF0E6),
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Fungsi untuk menangani percobaan login
  void login(LoginProvider provider) async {
    // Memanggil metode login pada database untuk memeriksa kecocokan username dan password
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));

    // Jika respon dari proses login adalah benar (true), maka arahkan pengguna ke halaman tugas (TodoPage)
    if (response == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const TodoPage()));
    } else {
      provider
          .setLoginTrue(); // Memperbarui status menggunakan provider jika login gagal
    }
  }
}
