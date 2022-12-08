// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:repoviewer/core/infrastructure/sembast_database.dart';
import 'package:repoviewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repoviewer/github/repos/starred_repos/infrastructure/pagination_config.dart';
import 'package:sembast/sembast.dart';

class StarredReposLocalService {
  final SembastDatabase _sembastDatabase;
  StarredReposLocalService(this._sembastDatabase);

  final _store = intMapStoreFactory.store("starredRepos");

  Future<void> upsertPage(List<GithubRepoDTO> dtos, int page) async {
    final sembastPage = page - 1;
    await _store
        .records(
          dtos.mapIndexed(
            (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
          ),
        )
        .put(
          _sembastDatabase.instance,
          dtos.map((e) => e.toJson()).toList(),
        );
  }

  Future<List<GithubRepoDTO>> getPage(int page) async {
    final sembastPage = page - 1;

    final records = await _store.find(
      _sembastDatabase.instance,
      finder: Finder(
        limit: PaginationConfig.itemsPerPage,
        offset: PaginationConfig.itemsPerPage * sembastPage,
      ),
    );
    return records.map((e) => GithubRepoDTO.fromJson(e.value)).toList();
  }
}
