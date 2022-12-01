import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Icon(
              Ionicons.logo_github,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
