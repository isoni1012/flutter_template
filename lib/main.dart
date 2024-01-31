import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/router/app_router.dart';
import 'package:flutter_base_project/di/app_config.dart';
import 'package:flutter_base_project/ui/cubits/local_articles/local_article_cubit.dart';
import 'package:flutter_base_project/ui/cubits/remote_articles/remote_articles_cubit.dart';
import 'package:flutter_base_project/data/datasources/local/prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'domain/repositories/api_repository.dart';
import 'domain/repositories/database_repository.dart';
import 'di/locator.dart';
import 'config/themes/color_schemes.dart';

Future<void> mainCommon() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  await initializeDependencies(AppConfig.shared.baseUrl);
  await Prefs.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalArticleCubit(
            locator<DatabaseRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) {
            return RemoteArticlesCubit(
              locator<ApiRepository>(),
            );
          },
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Flutter Base",
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        routerConfig: appRouter.config(),
      ),
    );
  }
}
