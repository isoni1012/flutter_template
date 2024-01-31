import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../ui/view/welcome_screen.dart';
import '../../ui/view/news_list_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, initial: true),
        AutoRoute(page: NewsListRoute.page),
      ];
}

final appRouter = AppRouter();
