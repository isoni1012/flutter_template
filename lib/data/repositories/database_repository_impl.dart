import '../../domain/models/article.dart';
import '../../domain/repositories/database_repository.dart';
import '../datasources/local/app_database.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<List<Article>> getSavedArticles() async {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> removeArticle(Article article) async {
    return _appDatabase.articleDao.deleteArticle(article);
  }

  @override
  Future<void> saveArticle(Article article) async {
    _appDatabase.articleDao.insertArticle(article);
    return _appDatabase.articleDao.insertArticle(article);
  }

  @override
  Future<void> saveArticles(List<Article> article) async {
    _appDatabase.articleDao.insertArticles(article);
    return _appDatabase.articleDao.insertArticles(article);
  }
}