import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/domain/auth_failure.dart';
import 'package:repoviewer/auth/infrastructure/github_authenticator.dart';

part 'auth_notifier.freezed.dart';

typedef AuthUriCallBack = Future<Uri> Function(Uri authorizationUrl);

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.unauthenticated() = _UnAuthenticated;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final GithubAuthenticator _authenticator;
  AuthNotifier(this._authenticator) : super(const AuthState.initial());

  Future<void> checkAndUpdateAuthStatus() async {
    await Future.delayed(const Duration(seconds: 4));
    state = (await _authenticator.isSignedIn())
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  Future<void> signIn(
    AuthUriCallBack authorizationCallBack,
  ) async {
    final grant = _authenticator.createGrant();
    final redirectUrl =
        await authorizationCallBack(_authenticator.getAuthorizationUri(grant));
    final failureOrSuccess = await _authenticator.handleAuthorizationResponse(
      grant,
      redirectUrl.queryParameters,
    );

    failureOrSuccess.fold(
      (l) => state = AuthState.failure(l),
      (r) => const AuthState.authenticated(),
    );

    grant.close();
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _authenticator.signOut();
    failureOrSuccess.fold(
      (l) => AuthState.failure(l),
      (r) => const AuthState.unauthenticated(),
    );
  }
}
