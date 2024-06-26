import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, '/onboarding');
      },
    );

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo_app.png',
        ),
      ),
    );
  }
}
