import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_news_headlines/di/dependency_injection.dart';
import 'package:health_news_headlines/presentation/blocs/health_news_bloc.dart';
import 'package:health_news_headlines/presentation/pages/health_news_page.dart';

final getIt = GetIt.instance;

void main() {
  DependencyInjector.setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HealthNewsBloc>(create: (_) => getIt<HealthNewsBloc>())
        ],
        child: const HealthNewsPage(),
      ),
    );
  }
}
