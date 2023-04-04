import 'package:get_it/get_it.dart';
import 'package:health_news_headlines/data/data_source/news_api.dart';
import 'package:health_news_headlines/data/repositpry/health_news_repository_impl.dart';
import 'package:health_news_headlines/domain/repository/health_news_repository.dart';
import 'package:health_news_headlines/presentation/blocs/health_news_bloc.dart';

final getIt = GetIt.instance;

class DependencyInjector {
  static setupDependencies() {
    getIt.registerLazySingleton<HealthNewsApi>(() => HealthNewsApi());
    getIt.registerLazySingleton<HealthNewsRepository>(
        () => HealthNewsRepositoryImpl(api: getIt<HealthNewsApi>()));
    getIt.registerFactory<HealthNewsBloc>(() =>
        HealthNewsBloc(healthNewsRepository: getIt<HealthNewsRepository>()));
  }
}
