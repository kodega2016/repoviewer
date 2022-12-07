import 'package:auto_route/auto_route.dart';
import 'package:repoviewer/auth/presentation/authorization_page.dart';
import 'package:repoviewer/auth/presentation/sign_in_page.dart';
import 'package:repoviewer/github/repos/starred_repos/presentation/starred_repos_page.dart';
import 'package:repoviewer/splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true, path: '/splash'),
    AutoRoute(page: SignInPage, path: '/sign-in'),
    AutoRoute(page: StarredReposPage, path: '/starred-repos'),
    AutoRoute(page: AuthorizationPage, path: '/authorization'),
  ],
)
class $AppRouter {}
