// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    NewsListRoute.name: (routeData) {
      final args = routeData.argsAs<NewsListRouteArgs>(
          orElse: () => const NewsListRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewsListScreen(key: args.key),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [NewsListScreen]
class NewsListRoute extends PageRouteInfo<NewsListRouteArgs> {
  NewsListRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NewsListRoute.name,
          args: NewsListRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NewsListRoute';

  static const PageInfo<NewsListRouteArgs> page =
      PageInfo<NewsListRouteArgs>(name);
}

class NewsListRouteArgs {
  const NewsListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NewsListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
