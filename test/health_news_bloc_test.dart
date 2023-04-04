import 'package:flutter_test/flutter_test.dart';
import 'package:health_news_headlines/data/data_source/news_api.dart';
import 'package:health_news_headlines/data/repositpry/health_news_repository_impl.dart';
import 'package:health_news_headlines/domain/entities/article.dart';
import 'package:health_news_headlines/presentation/blocs/health_news_bloc.dart';
import 'package:health_news_headlines/presentation/models/health_news_event.dart';
import 'package:health_news_headlines/presentation/models/health_news_state.dart';
import 'package:mockito/mockito.dart';

class MockNewsApi extends Mock implements HealthNewsApi {}

void main() {
  late HealthNewsBloc healthNewsBloc;
  late HealthNewsRepositoryImpl mockRepository;
  late MockNewsApi mockNewsApi;
  setUpAll(() {
    mockNewsApi = MockNewsApi();
    mockRepository = HealthNewsRepositoryImpl(api: mockNewsApi);
    healthNewsBloc = HealthNewsBloc(healthNewsRepository: mockRepository);
  });
  group('HealthNewsBloc', () {
    test('emits HealthNewsLoadSuccess when HealthNewsFetched is added', () {
      // Arrange
      final articles = [
        Article(
            title: 'Test article 1',
            description: 'Description 1',
            urlToImage: 'https://www.example.com/image1.png',
            publishedAt: DateTime.now(),
            author: '',
            content: '',
            url: ''),
        Article(
            title: 'Test article 2',
            description: 'Description 2',
            urlToImage: 'https://www.example.com/image2.png',
            publishedAt: DateTime.now(),
            author: '',
            content: '',
            url: ''),
      ];
      print(mockNewsApi.getHealthNews());
      when(mockNewsApi.getHealthNews()).thenAnswer((_) async => articles);
      when(mockRepository.fetchHealthNews()).thenAnswer((_) async => articles);

      // Act
      healthNewsBloc.add(FetchHealthNewsEvent());

      // Assert
      expectLater(
        healthNewsBloc,
        emitsInOrder([
          isA<HealthNewsLoadingState>(),
          isA<HealthNewsLoadedState>()
              .having((state) => state.articles, 'articles', articles),
        ]),
      );
    });
  });
}
