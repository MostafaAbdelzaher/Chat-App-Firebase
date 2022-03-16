import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  static const String id = "StartScreen";
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: AnimatedTextKit(
          repeatForever: false,
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              'Flash Chat',
              textStyle: const TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 200),
            ),
          ],
          onFinished: () {
            Navigator.pushNamed(context, WelcomeScreen.id);
          },
        ),
      ),
    );
  }
}
