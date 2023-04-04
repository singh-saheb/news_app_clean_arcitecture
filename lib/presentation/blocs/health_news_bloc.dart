import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_news_headlines/domain/entities/article.dart';
import 'package:health_news_headlines/domain/repository/health_news_repository.dart';
import 'package:health_news_headlines/presentation/models/health_news_event.dart';
import 'package:health_news_headlines/presentation/models/health_news_state.dart';

class HealthNewsBloc extends Bloc<HealthNewsEvent, HealthNewsState> {
  final HealthNewsRepository _healthNewsRepository;

  HealthNewsBloc({required HealthNewsRepository healthNewsRepository})
      : _healthNewsRepository = healthNewsRepository,
        super(HealthNewsInitial()) {
    on<FetchHealthNewsEvent>((event, emit) async {
      emit(HealthNewsLoadingState());
      try {
        final List<Article> articles =
            await _healthNewsRepository.fetchHealthNews();
        emit(HealthNewsLoadedState(articles: articles));
      } catch (error) {
        emit(HealthNewsErrorState(errorMessage: error.toString()));
      }
    });
  }
}
