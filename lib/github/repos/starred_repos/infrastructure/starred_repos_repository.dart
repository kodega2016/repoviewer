import 'package:dartz/dartz.dart';
import 'package:repoviewer/core/domain/fresh.dart';
import 'package:repoviewer/core/infrastructure/network_exception.dart';
import 'package:repoviewer/github/core/domain/github_failure.dart';
import 'package:repoviewer/github/core/domain/github_repo.dart';
import 'package:repoviewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repoviewer/github/repos/starred_repos/infrastructure/starred_repos_remote_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;
  //TODO:: add local service

  StarredReposRepository(this._remoteService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
    int page,
  ) async {
    try {
      final remotePageItems = await _remoteService.getStarredReposPage(page);
      return right(
        remotePageItems.when(
          noConnection: (maxPage) => const Fresh(entity: [], isFresh: false),
          notMofified: (maxPage) => const Fresh(entity: [], isFresh: false),
          withNewData: (data, maxPage) {
            //TODO:: save data to the local service
            return Fresh.yes(
              data.toDomain(),
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}

extension DTOListToDomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
