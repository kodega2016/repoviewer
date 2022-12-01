import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
          children: [
            const Icon(
              Ionicons.logo_github,
              size: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome to\nRepo Viewer",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.green,
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Sign in with Github",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
