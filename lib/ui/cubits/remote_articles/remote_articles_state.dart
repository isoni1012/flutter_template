part of 'remote_articles_cubit.dart';

/*
This is abstract state class for RemoteArticles api response which provide you current state of api calling which are loading, success or failed
*/

abstract class RemoteArticlesState extends Equatable {
  final List<Article> articles;
  final bool noMoreData;
  final String? error;

  const RemoteArticlesState(
      {this.articles = const [], this.noMoreData = false, this.error});

  @override
  List<Object?> get props => [articles, noMoreData, error];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesSuccess extends RemoteArticlesState {
  const RemoteArticlesSuccess({super.articles, super.noMoreData});
}

class RemoteArticlesFailed extends RemoteArticlesState {
  const RemoteArticlesFailed({super.error});
}


class RemoteArticlesDataUpdating extends RemoteArticlesState {
  const RemoteArticlesDataUpdating({super.articles});
}
