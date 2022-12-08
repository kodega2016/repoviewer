import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repoviewer/core/domain/fresh.dart';
import 'package:repoviewer/github/core/domain/github_failure.dart';
import 'package:repoviewer/github/core/domain/github_repo.dart';

part 'starred_repos_notifier.freezed.dart';

@freezed
class StarredReposState with _$StarredReposState {
  const StarredReposState._();
  const factory StarredReposState.initial(
    Fresh<List<GithubRepo>> repos,
  ) = _Initial;
  const factory StarredReposState.loadInProgress(
    Fresh<List<GithubRepo>> repos,
  ) = _LoadInProgress;
  const factory StarredReposState.loadSuccess(
    Fresh<List<GithubRepo>> repos, {
    required bool isNextPageAvailable,
  }) = _LoadSuccess;

  const factory StarredReposState.loadFailure(
    GithubFailure failure,
  ) = _LoadFailure;
}
