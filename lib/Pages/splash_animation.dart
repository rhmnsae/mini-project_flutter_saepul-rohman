import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_todo_list/Controllers/splash_animation_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({Key? key}) : super(key: key);

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> {
  final SplashAnimationController splashAnimationController =
      SplashAnimationController();

  @override
  void initState() {
    super.initState();
    splashAnimationController.splashTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF352F44),
      ),
      backgroundColor: const Color(0xFF352F44),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 100.0,
          ),
          child: DefaultTextStyle(
            style: GoogleFonts.firaCode(
              fontSize: 40.0,
              color: const Color(0xFFB9B4C7),
              fontWeight: FontWeight.bold,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Simple To-Do'),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                if (kDebugMode) {
                  print("Tap Event");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
