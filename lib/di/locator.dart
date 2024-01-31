import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_project/utils/constants/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/datasources/local/app_database.dart';
import '../data/repositories/api_repository_impl.dart';
import '../data/datasources/remote/app_api_service.dart';
import '../data/repositories/database_repository_impl.dart';
import '../domain/repositories/api_repository.dart';
import '../domain/repositories/database_repository.dart';

/*
We use "GetIt" library for dependency injection as you can see we created dio object and mark it as singleton,
so when you want to pass dio as parameter anywhere in project you use like this locator<Dio>()
for example here we register singleton for "ApiRepositoryImpl" but for create its object its need object "NewsApiService" as parameter
so again we register singleton for "NewsApiService" but again for that its required object of "Dio" as parameter we register singleton of "Dio"
*/

final locator = GetIt.instance;

Future<void> initializeDependencies(String baseUrl) async {
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  locator.registerSingleton<AppDatabase>(db);

  final dio = Dio();

  //AwesomeDioInterceptor is library which provides logs of api calling
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<AppApiService>(
    AppApiService(locator<Dio>()),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<AppApiService>()),
  );

  locator.registerSingleton<DatabaseRepository>(
    DatabaseRepositoryImpl(locator<AppDatabase>()),
  );
}
