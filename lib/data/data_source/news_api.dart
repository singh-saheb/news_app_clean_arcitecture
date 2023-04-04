import 'dart:convert';

import 'package:health_news_headlines/data/config/config.dart';
import 'package:health_news_headlines/domain/entities/article.dart';
import 'package:http/http.dart' as http;

class HealthNewsApi {
  Future<List<Article>> getHealthNews() async {
    try {
      final url = '$baseUrl&apiKey=$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> articleList = jsonData['articles'];
        return articleList.map((e) => Article.fromJson(e)).toList().cast<Article>();
      } else {
        throw Exception('Failed to load health news');
      }
    } catch (e) {
      throw Exception("Failed");
    }
  }
}
