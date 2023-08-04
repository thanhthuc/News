
// Difference between abstract vs interface
// Keyword: implement & extend
// Multi inherited
// https://developermemos.com/posts/dart-abstract-classes-interfaces

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news/model/news_model.dart';
import 'package:http/http.dart';

abstract class BaseAPI {
  String get baseURL;
  Future<List<News>> fetchNews(Client client);
}

abstract class Parse {
  List<News> parseNewsFrom(String jsonResponseBody);
}

class APIClient implements BaseAPI, Parse {
  // https://docs.flutter.dev/cookbook/networking/background-parsing
  // What is isolate?

  String apiKey = "8ccb67aaefd4475ba20a6bb2ef79a35d";

  @override
  // TODO: implement baseURL
  // GET https://newsapi.org/v2/everything?q=Apple&from=2023-08-03&sortBy=popularity&apiKey=API_KEY
  String get baseURL => "https://newsapi.org/v2/everything?q=Apple&from=2023-08-03&sortBy=popularity&apiKey=$apiKey";

  @override
  Future<List<News>> fetchNews(Client client) async {
    final response = await client.get(Uri.parse(baseURL));
    // List<News> list = parseNewsFrom(response.body); => app freeze for a moment
    // Use compute to isolate to background thread
    return compute(parseNewsFrom, response.body);
  }

  @override
  List<News> parseNewsFrom(String jsonResponseBody) {
    // TODO: implement parseNewsFrom
    final parsed = jsonDecode(jsonResponseBody).cast<Map<String, dynamic>>();
    var listNews = parsed.map<News>((json) => News.fromJson(json as Map<String, dynamic>)).toList();
    return listNews;
  }

}
