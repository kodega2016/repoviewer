import 'package:repoviewer/core/infrastructure/sembast_database.dart';
import 'package:repoviewer/github/core/infrastructure/github_headers.dart';
import 'package:sembast/sembast.dart';

class GithubHeadersCache {
  final SembastDatabase _sembastDatabase;
  GithubHeadersCache(this._sembastDatabase);

  final _store = stringMapStoreFactory.store("headers");

  Future<void> saveHeaders(
    Uri uri,
    GithubHeaders headers,
  ) async {
    await _store.record(uri.toString()).put(
          _sembastDatabase.instance,
          headers.toJson(),
        );
  }

  Future<GithubHeaders?> getHeaders(Uri uri) async {
    final json =
        await _store.record(uri.toString()).get(_sembastDatabase.instance);
    if (json == null) return null;
    return GithubHeaders.fromJson(json);
  }

  Future<void> deleteHeaders(Uri uri) async {
    await _store.record(uri.toString()).delete(_sembastDatabase.instance);
  }
}
