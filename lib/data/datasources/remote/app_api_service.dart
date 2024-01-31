import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../di/app_config.dart';
import '../../../domain/models/responses/breaking_news_response.dart';
import '../../../utils/constants/strings.dart';

part 'app_api_service.g.dart';

/*
In this abstract class all api with endpoint are declare
*/

@RestApi(parser: Parser.MapSerializable)
abstract class AppApiService {
  @factoryMethod
  factory AppApiService(Dio dio) => _AppApiService(dio,
      baseUrl: AppConfig.shared.baseUrl); // I can inject baseUrl here

  @GET('/top-headlines')
  Future<HttpResponse<BreakingNewsResponse>> getBreakingNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("sources") String? sources,
    @Query("page") int? page,
    @Query("pageSize") int? pageSize,
  });
}
