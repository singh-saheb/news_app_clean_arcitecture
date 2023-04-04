import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_news_headlines/presentation/blocs/health_news_bloc.dart';
import 'package:health_news_headlines/presentation/models/health_news_event.dart';
import 'package:health_news_headlines/presentation/models/health_news_state.dart';

class HealthNewsPage extends StatefulWidget {
  const HealthNewsPage({super.key});
  @override
  State<HealthNewsPage> createState() => _HealthNewsPageState();
}

class _HealthNewsPageState extends State<HealthNewsPage> {
  late HealthNewsBloc _healthNewsBloc;

  @override
  void initState() {
    super.initState();
    _healthNewsBloc = BlocProvider.of<HealthNewsBloc>(context);
    _healthNewsBloc.add(FetchHealthNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health News'),
      ),
      body: BlocBuilder<HealthNewsBloc, HealthNewsState>(
        bloc: _healthNewsBloc,
        builder: (context, state) {
          if (state is HealthNewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HealthNewsLoadedState) {
            final articles = state.articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: article.urlToImage.isNotEmpty
                              ? Image.network(article.urlToImage)
                              : const Placeholder(),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(article.description),
                              const SizedBox(height: 8.0),
                              Text(
                                'By ${article.author}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                article.publishedAt.toString(),
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is HealthNewsErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
