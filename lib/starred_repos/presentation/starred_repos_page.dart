import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repoviewer/auth/shared/providers.dart';

class StarredReposPage extends ConsumerWidget {
  const StarredReposPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Starred Repos"),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(authNotifierProvider.notifier).signOut();
            },
            icon: const Icon(Ionicons.exit_outline),
          )
        ],
      ),
    );
  }
}
