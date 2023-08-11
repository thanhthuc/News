import 'dart:async';

import 'package:news/api_client/api_client.dart';

import '../../model/news_model.dart';

abstract class NewsListStreamImpl {
  StreamController<List<News>> getList();
}

class NewsListStream implements NewsListStreamImpl {

  final APIClient _apiClient = APIClient();

  final StreamController<List<News>> _streamController = StreamController<List<News>>();

  Future<List<News>> fetchData() async {
    // TODO: implement fetchData
    var list = await _apiClient.fetchNews();
    return list;
  }

  @override
  StreamController<List<News>> getList() {
    Sink sink = _streamController.sink;
    var list = fetchData();
    sink.add(list);
    return _streamController;
  }
}