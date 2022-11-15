import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('LoginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.withOpacity(0.8),
      body: Container(
        alignment: Alignment.center,
        //color: const Color(0xff777be7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/user-login-icon-14.png",
              scale: 2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const LinearProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.white,
              minHeight: 12,
            ),
          ],
        ),
      ),
    );
  }
}
