
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    Future.delayed(const Duration(seconds: 2), () {

      context.go('/nav'); 
    });

    return Scaffold(
      backgroundColor: Colors.orange, 
      body: Center(
        child: Image.asset(
          'assets/Frame 7.png',
          fit: BoxFit.contain, 
        ),
      ),
    );
  }
}
