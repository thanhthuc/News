
// Difference between abstract vs interface
// Keyword: implement & extend
// Multi inherited
// https://developermemos.com/posts/dart-abstract-classes-interfaces

import 'package:news/model/news_model.dart';

abstract class BaseAPI {
  String get baseURL;
  void fetchData(String responseBody);
}

abstract class Parse {
  void parse();
}

class APIClient implements BaseAPI {
  // https://docs.flutter.dev/cookbook/networking/background-parsing
  // What is isolate?
  @override
  List<News> fetchData(String responseBody) {
    // TODO: implement fetchData

    return [];
  }

  @override
  // TODO: implement baseURL
  String get baseURL => "baseURL";

}
