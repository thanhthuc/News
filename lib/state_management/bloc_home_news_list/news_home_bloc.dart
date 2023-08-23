import 'dart:async';import 'package:news/api_client/api_client.dart';import 'package:news/small_component/published_dropdown_view.dart';import 'package:rxdart/rxdart.dart';import '../../model/news_model.dart';enum HomeTabViewType {  allNews, topNews, technical}abstract class Bloc {  void dispose();}class ListNewsBloc implements Bloc {  final APIClient _apiClient = APIClient();  StreamController<List<News>> listTechNewsStream = BehaviorSubject();  StreamController<List<News>> topListNewsStream = BehaviorSubject();  StreamController<List<News>> allListNewsStream = BehaviorSubject();  StreamController<bool> isLoadingStream = BehaviorSubject();  int _currentPage = 1;  DropdownFilterState _sortBy = DropdownFilterState.publishAt;  void fetchTechListNews() async {    var list = await _apiClient.fetchTechNews();    listTechNewsStream.add(list);  }  void fetchTopListNews() async {    var list = await _apiClient.fetchTopNews();    topListNewsStream.add(list);  }  void fetchAllListNews() async {    var list = await _apiClient.fetchAllNews();    allListNewsStream.add(list);  }  void fetchTechListNewsByPage(int page) async {    _currentPage = page;    var list = await _apiClient.fetchNewsWith(page * 5, _sortBy);    listTechNewsStream.add(list);  }  void fetchTechListNewsBySortBy(DropdownFilterState sortBy) async {    _sortBy = sortBy;    var list = await _apiClient.fetchNewsWith(_currentPage * 5, sortBy);    listTechNewsStream.add(list);  }  void toPreviousPage() async {    _currentPage -= 1;    var list = await _apiClient.fetchNewsWith(_currentPage * 5, _sortBy);    listTechNewsStream.add(list);  }  void toNextPage() async {    _currentPage += 1;    var list = await _apiClient.fetchNewsWith(_currentPage * 5, _sortBy);    listTechNewsStream.add(list);  }  @override  void dispose() {    listTechNewsStream.close();    isLoadingStream.close();    topListNewsStream.close();    allListNewsStream.close();  }}