import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:repoviewer/auth/shared/providers.dart';
import 'package:repoviewer/core/presentation/routes/app_router.gr.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
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
                    onPressed: () {
                      ref
                          .read(authNotifierProvider.notifier)
                          .signIn((authorizationUrl) async {
                        final completer = Completer<Uri>();

                        AutoRouter.of(context).push(
                          AuthorizationRoute(
                            authorizationUrl: authorizationUrl,
                            onAuthorizationCodeRedirectAttempt: (url) {
                              completer.complete(url);
                            },
                          ),
                        );
                        return completer.future;
                      });
                    },
                    child: const Text(
                      "Sign in with Github",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
