import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/article.dart';
import '../../../domain/repositories/database_repository.dart';

part 'local_article_state.dart';

class LocalArticleCubit extends Cubit<LocalArticleState> {
  final DatabaseRepository _databaseRepository;

  LocalArticleCubit(this._databaseRepository) : super(const LocalArticleLoading());

  Future<void> getAllSavedArticles() async {
    emit(await _getAllSavedArticles());
  }

  Future<void> removeArticle({required Article article}) async {
    await _databaseRepository.removeArticle(article);
    emit(await _getAllSavedArticles());
  }

  Future<void> saveArticle({required Article article}) async {
    await _databaseRepository.saveArticle(article);
    emit(await _getAllSavedArticles());
  }

  Future<void> saveArticles({required List<Article> articles}) async {
    await _databaseRepository.saveArticles(articles);
    emit(await _getAllSavedArticles());
  }

  Future<LocalArticleState> _getAllSavedArticles() async {
    final articles = await _databaseRepository.getSavedArticles();
    print("db count--> ${articles.length}");
    return LocalArticleSuccess(articles: articles);
  }
}
