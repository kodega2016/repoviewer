import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repoviewer/auth/domain/auth_failure.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.unauthenticated() = _UnAuthenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}
