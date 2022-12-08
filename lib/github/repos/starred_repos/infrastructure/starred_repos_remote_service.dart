import 'package:dio/dio.dart';
import 'package:repoviewer/core/infrastructure/dio_extensions.dart';
import 'package:repoviewer/core/infrastructure/network_exception.dart';
import 'package:repoviewer/core/infrastructure/remote_response.dart';
import 'package:repoviewer/github/core/infrastructure/github_headers.dart';
import 'package:repoviewer/github/core/infrastructure/github_headers_cache.dart';
import 'package:repoviewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repoviewer/github/repos/starred_repos/infrastructure/pagination_config.dart';

class StarredReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache _cache;

  StarredReposRemoteService(
    this._dio,
    this._cache,
  );

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
    int page,
  ) async {
    const token = "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";
    const accept = "application/vnd.github.v3.html+json";

    final requestUri = Uri.https("api.github.com", "/user/starred", {
      "page": "$page",
      "per_page": PaginationConfig.itemsPerPage.toString(),
    });

    final previousHeaders = await _cache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            "Authorization": "bearer $token",
            "Accept": accept,
            "If-None-Match": previousHeaders?.etag ?? ""
          },
        ),
      );
      if (response.statusCode == 304) {
        return RemoteResponse.notMofified(
          maxPage: previousHeaders?.link?.maxPage ?? 0,
        );
      } else if (response.statusCode == 200) {
        final headers = GithubHeaders.parse(response);
        await _cache.saveHeaders(requestUri, headers);

        final convertedData = (response.data as List<dynamic>)
            .map((e) => GithubRepoDTO.fromJson(e as Map<String, dynamic>))
            .toList();

        return RemoteResponse.withNewData(
          convertedData,
          maxPage: headers.link?.maxPage ?? 1,
        );
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return RemoteResponse.noConnection(
          maxPage: previousHeaders?.link?.maxPage ?? 0,
        );
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
