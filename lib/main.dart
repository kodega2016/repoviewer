import 'package:flutter/material.dart';

void main() {
  runApp(const RepoViewer());
}

class RepoViewer extends StatelessWidget {
  const RepoViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
