part of 'local_article_cubit.dart';

abstract class LocalArticleState extends Equatable {
  final List<Article> articles;

  const LocalArticleState({this.articles = const []});

  @override
  List<Object?> get props => [articles];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleSuccess extends LocalArticleState {
  const LocalArticleSuccess({super.articles});
}
