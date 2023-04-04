import 'package:health_news_headlines/data/data_source/news_api.dart';
import 'package:health_news_headlines/domain/entities/article.dart';
import 'package:health_news_headlines/domain/repository/health_news_repository.dart';

class HealthNewsRepositoryImpl implements HealthNewsRepository {
  final HealthNewsApi api;
  HealthNewsRepositoryImpl({required this.api});

  @override
  Future<List<Article>> fetchHealthNews() {
    return api.getHealthNews();
  }
}
