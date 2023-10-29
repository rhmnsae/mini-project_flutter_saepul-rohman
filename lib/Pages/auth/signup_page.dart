// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_todo_list/Models/db_helper.dart';
import 'package:simple_todo_list/Models/user_model.dart';
import 'package:simple_todo_list/Pages/auth/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Providers/signup_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF352F44),
      body: ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
        child: Consumer<SignUpProvider>(
          builder: (context, provider, child) {
            return Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(
                            "Register",
                            style: GoogleFonts.firaCode(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFB9B4C7),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        // Username input field
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
                        // Password input field
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
                            cursorColor: const Color(0xFFB9B4C7),
                            controller: password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              }
                              return null;
                            },
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

                        /// Confirm Password input field

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
                            cursorColor: const Color(0xFFB9B4C7),
                            controller: confirmPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              } else if (password.text !=
                                  confirmPassword.text) {
                                return "Passwords don't match";
                              }
                              return null;
                            },
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

                        // Sign-up button
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFB9B4C7),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                signUp(context.read<SignUpProvider>());
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.firaCode(
                                color: const Color(0xFF5C5470),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.firaCode(
                                color: const Color(0xFFB9B4C7),
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.firaCode(
                                  color: const Color(0xFFFAF0E6),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
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

  void signUp(SignUpProvider provider) async {
    final db = DatabaseHelper();
    await db.signup(Users(
      usrName: username.text,
      usrPassword: password.text,
    ));

    provider.setSignUpSuccess();
    if (provider.isSignUpSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}
