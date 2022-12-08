import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/application/auth_notifier.dart';
import 'package:repoviewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:repoviewer/auth/infrastructure/credentials_storage/secure_credentials_storage.dart';
import 'package:repoviewer/auth/infrastructure/github_authenticator.dart';
import 'package:repoviewer/auth/infrastructure/oauth2_interceptors.dart';

final dioForAuthProvider = Provider<Dio>((ref) => Dio());

final oAuth2IntercepterProvider = Provider(
  (ref) => OAuth2Interceptor(
    ref.watch(githubAuthenticatorProvider),
    ref.watch(authNotifierProvider.notifier),
    ref.watch(dioForAuthProvider),
  ),
);

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
    ref.watch(dioForAuthProvider),
  ),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier(
      ref.watch(githubAuthenticatorProvider),
    );
  },
);
