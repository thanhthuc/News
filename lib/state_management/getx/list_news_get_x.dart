
import 'package:get/get.dart';
import 'package:news/api_client/api_client.dart';

import '../../model/news_model.dart';

class ListNewsController extends GetxController {

  final APIClient _apiClient = APIClient();

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

}