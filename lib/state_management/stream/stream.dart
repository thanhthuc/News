import 'dart:async';
import 'package:news/api_client/api_client.dart';
import 'package:news/small_component/published_dropdown_view.dart';
import '../../model/news_model.dart';

abstract class NewsListStreamImpl {
  void getList();
}

abstract class NewsPageStateI {
  late bool isAllNew;
  late bool isLoading;
  late List<News> list;
}

class NewsPageState implements NewsPageStateI {
  @override
  bool isAllNew = true;

  @override
  bool isLoading = true;

  @override
  List<News> list = [];

}

class NewsListStreamModel implements NewsListStreamImpl {

  final APIClient _apiClient = APIClient();
  DropdownFilterState sortBy = DropdownFilterState.popularity;
  int currentPage = 1;
  NewsPageState newsPageState = NewsPageState();
  final StreamController<NewsPageState>? streamController = StreamController<NewsPageState>();

  @override
  void getList() async {
    var sink = streamController?.sink;
    var list = await _apiClient.fetchNews();
    newsPageState.isLoading = false;
    newsPageState.list = list;
    newsPageState.isAllNew = true;
    sink?.add(newsPageState);
  }

  void preCallbackHandle() {
    currentPage -= 1;
    fetchNews(currentPage, sortBy);
  }

  void nextCallbackHandle() {
    currentPage += 1;
    fetchNews(currentPage, sortBy);
  }

  void fetchNews(int page, DropdownFilterState sortBy) async {
    currentPage = page;
    this.sortBy = sortBy;
    var newList = await _apiClient.fetchNewsWith(page * 5, sortBy);
    newsPageState.isLoading = false;
    newsPageState.list = newList;
    streamController?.sink.add(newsPageState);
  }

  void fetchTopHeading() async {
    var newList = await _apiClient.fetchTopNews();
    newsPageState.isLoading = false;
    newsPageState.list = newList;
    newsPageState.isAllNew = false;
    streamController?.sink.add(newsPageState);
  }

  // Stream<List<News>> listStream() async* {
  //   var list = await getList();
  //   yield list;
  // }
}