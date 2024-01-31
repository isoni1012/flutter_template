import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/article.dart';
import '../../../domain/models/requests/breaking_news.request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../../utils/resources/data_state.dart';
import '../../../utils/constants/nums.dart';
import '../../../utils/helper.dart';
import '../base/base_cubit.dart';

part 'remote_articles_state.dart';

/*
This is cubit class of RemoteArticles api which extend BaseCubit
As we discuss in BaseCubit we require S and T where S if State and T is Data
So here S id RemoteArticleState and T is list of Articles. At initial level state will be loading and data will be empty list
For calling api we need object of ApiRepository which we are passing in constructor.
*/

class RemoteArticlesCubit
    extends BaseCubit<RemoteArticlesState, List<Article>> {
  final ApiRepository _apiRepository;

  RemoteArticlesCubit(this._apiRepository)
      : super(const RemoteArticlesLoading(), []);

  int _page = 1;

  //UI will access this method for calling BreakingNewsArticles api
  Future<void> getBreakingNewsArticles() async {
    //It will check first cubit is busy or not
    if (isBusy) return;

    bool isInternetAvailable = await Helper.isInternetAvailable();

    if (isInternetAvailable) {
      await run(() async {
        final response = await _apiRepository.getBreakingNewsArticles(
          request: BreakingNewsRequest(page: _page,pageSize: defaultPageSize),
        );

        //Response is Success then it will emit SuccessResponse else FailResponse
        if (response is DataSuccess) {
          final articles = response.data!.articles;
          final noMoreData = articles.length < defaultPageSize;

          data.addAll(articles);
          _page++;
          print(
              "new data-----------------------------------------------> ${data.length}");
          emit(RemoteArticlesSuccess(articles: data, noMoreData: noMoreData));
        } else if (response is DataFailed) {
          emit(RemoteArticlesFailed(
              error: (response.error != null)
                  ? response.error!.message
                  : "Error"));
        }
      });
    } else {
      emit(const RemoteArticlesFailed(error: "No internet"));
    }
  }

  Future<void> update(int index) async {
    emit(RemoteArticlesDataUpdating());
    data[0].title = "${data[0].title} $index";
    emit(RemoteArticlesSuccess(articles: data, noMoreData: true));
  }
}
