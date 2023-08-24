
import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../api_client/api_client.dart';
import '../../model/news_model.dart';
import '../bloc_home_news_list/news_home_bloc.dart';

class SearchBloc implements Bloc {

  final APIClient _apiClient = APIClient();

  final StreamController<String?> _queryController = StreamController();
  Sink<String?> get searchQuerySink => _queryController.sink;
  late Stream<List<News>> stream;

  SearchBloc() {
    stream = _queryController
        .stream
        .startWith(null)
        .debounceTime(const Duration(milliseconds: 300)) // 2
        .switchMap((event) {
      print("object--");
      return fetchNews(event).asStream().startWith([]);
    });
  }

  StreamController<List<News>> listNewsStream = PublishSubject();

  Future<List<News>> fetchNews(String? query) async {
    var list = await _apiClient.searchNews(query ?? "");
    return list;
  }

  @override
  void dispose() {
    listNewsStream.close();
  }
}

