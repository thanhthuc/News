
import 'package:get/get.dart';
import 'package:news/api_client/api_client.dart';

import '../../model/news_model.dart';
import '../../small_component/published_dropdown_view.dart';

class ListNewsController extends GetxController {

  final APIClient _apiClient = APIClient();
  int _currentPage = 1;
  var _sortBy = DropdownFilterState.publishAt;

  var listAllNews = <News>[].obs;
  var listTopNews = <News>[].obs;
  var listTechNews = <News>[].obs;

  void getAllNews() async {
    var list = await _apiClient.fetchAllNews();
    listAllNews.addAll(list);
  }

  void getTopNews() async {
    var list = await _apiClient.fetchTopNews();
    listTopNews.addAll(list);
  }

  void getTechNews() async {
    var list = await _apiClient.fetchTechNews();
    listTechNews.addAll(list);
  }

  void fetchTechListNewsByPage(int page) async {
    _currentPage = page;
    var list = await _apiClient.fetchNewsWith(page * 5, _sortBy);
    listTechNews.addAll(list);
  }

  void fetchTechListNewsBySortBy(DropdownFilterState sortBy) async {
    _sortBy = sortBy;
    var list = await _apiClient.fetchNewsWith(_currentPage * 5, sortBy);
    listTechNews.addAll(list);
  }

  void toPreviousPage() async {
    _currentPage -= 1;
    var list = await _apiClient.fetchNewsWith(_currentPage * 5, _sortBy);
    listTechNews.addAll(list);
  }

  void toNextPage() async {
    _currentPage += 1;
    var list = await _apiClient.fetchNewsWith(_currentPage * 5, _sortBy);
    listTechNews.addAll(list);
  }
}