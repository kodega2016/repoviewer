import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/shared/providers.dart';
import 'package:repoviewer/core/presentation/routes/app_router.gr.dart';
import 'package:repoviewer/core/shared/providers.dart';

final initializationProvider = FutureProvider((ref) async {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  await ref.read(sembastProvider).init();

  ref.read(dioProvider)
    ..options = BaseOptions(
      headers: {
        "Accept": "application/vnd.github.v3.html+json",
      },
    )
    ..interceptors.add(
      ref.watch(oAuth2IntercepterProvider),
    );

  await authNotifier.checkAndUpdateAuthStatus();
});

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (previous, next) {});

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeMap(
        authenticated: (_) {
          appRouter.pushAndPopUntil(
            const StarredReposRoute(),
            predicate: (route) => false,
          );
        },
        unauthenticated: (_) {
          appRouter.pushAndPopUntil(
            const SignInRoute(),
            predicate: (route) => false,
          );
        },
        orElse: () {},
      );
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: GoogleFonts.passeroOne().fontFamily,
      ),
      title: "Repo Viewer",
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
