import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import '../components/component.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    // animation = CurvedAnimation(
    //   curve: Curves.easeIn,
    //   parent: controller!,
    // );
    // animation =
    //     ColorTween(begin: Colors.red, end: Colors.blue).animate(controller!);
    controller!.forward();
    // animation!.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller!.reverse(from: 1.0); // decreases
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller!.forward(); // Increases
    //   }
    // });
    controller!.addListener(() // To change the value
        {
      setState(() {});
    });
    print(controller!.value);
  }

  // @override
  // void dispose() {
  //   controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(controller!.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                      child: Image.asset('images/logo.png'), height: 70),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            RoundButton(
                color: Colors.lightBlueAccent,
                text: 'Login',
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundButton(
                color: Colors.blueAccent,
                text: 'Register',
                onPress: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
