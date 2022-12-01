import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/application/auth_notifier.dart';
import 'package:repoviewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:repoviewer/auth/infrastructure/credentials_storage/secure_credentials_storage.dart';
import 'package:repoviewer/auth/infrastructure/github_authenticator.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final flutterSecureStorageProvider =
    Provider<FlutterSecureStorage>((_) => const FlutterSecureStorage());

final credentialStorageProvider = Provider<CredentialsStorage>(
  (ref) => SecureCredentialsStorage(
    ref.watch(flutterSecureStorageProvider),
  ),
);

final githubAuthenticatorProvider = Provider(
  (ref) => GithubAuthenticator(
    ref.watch(credentialStorageProvider),
    ref.watch(dioProvider),
  ),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier(
      ref.watch(githubAuthenticatorProvider),
    );
  },
);
