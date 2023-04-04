import 'package:health_news_headlines/domain/entities/article.dart';

abstract class HealthNewsRepository {
  Future<List<Article>> fetchHealthNews();
}
