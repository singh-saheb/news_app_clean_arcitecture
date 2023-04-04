import 'package:equatable/equatable.dart';
import 'package:health_news_headlines/domain/entities/article.dart';

abstract class HealthNewsState extends Equatable {
  const HealthNewsState();

  @override
  List<Object> get props => [];
}

class HealthNewsInitial extends HealthNewsState {}

class HealthNewsLoadingState extends HealthNewsState {}

class HealthNewsLoadedState extends HealthNewsState {
  final List<Article> articles;

  const HealthNewsLoadedState({required this.articles});

  @override
  List<Object> get props => [articles];
}

class HealthNewsErrorState extends HealthNewsState {
  final String errorMessage;

  const HealthNewsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
