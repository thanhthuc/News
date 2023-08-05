
// Difference between abstract vs interface
// Keyword: implement & extend
// Multi inherited
// https://developermemos.com/posts/dart-abstract-classes-interfaces

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:news/model/news_model.dart';
import 'package:http/http.dart';
import 'package:news/model/object_model.dart';

abstract class BaseAPI {
  String get baseURL;
  String get apiKey;
  late Map<String, dynamic> parameters;
  Future<List<News>> fetchNews();
  Future<List<NewsListObject>> fetchNewsListObject();
}

abstract class Parse<T> {
  List<T> parseObjectFrom(String jsonResponseBody);
}

class ParseNews implements Parse {
  @override
  List<News> parseObjectFrom(String jsonResponseBody) {
    // TODO: implement parseObjectFrom

    var parsedObjectParent = jsonDecode(jsonResponseBody).cast<String, dynamic>();
    if(kDebugMode) {
      print("parsed: $parsedObjectParent");
    }
    var listNews = parsedObjectParent["articles"];
    return listNews.map<News>((json) => News.fromJson(json)).toList();
  }
}

class ParseNewObject implements Parse {
  @override
  List<NewsListObject> parseObjectFrom(String jsonResponseBody) {
    // TODO: implement parseObjectFrom
    var parsed = jsonDecode(jsonResponseBody);
    if (kDebugMode) {
      print("parsed: $parsed");
    }
    return parsed.map<NewsListObject>((json) => NewsListObject.fromJson(json)).toList();
  }
}

class APIClient implements BaseAPI {
  // What is isolate?
  final Client _client = Client();

  @override
  String apiKey = "8ccb67aaefd4475ba20a6bb2ef79a35d";
  // GET https://newsapi.org/v2/everything?q=Apple&from=2023-08-03&sortBy=popularity&apiKey=API_KEY
  // String get baseURL => "https://newsapi.org/v2/everything?q=Apple&from=2023-08-03&sortBy=popularity&apiKey=$apiKey";

  @override
  // TODO: implement parameters
  Map<String, dynamic> get parameters {
    var queryParameter = {
      "q":"Apple",
      // "from":2023-08-05,
      // "pageSize":5,
      "sortBy":"popularity",
      "apiKey":apiKey
    };
    return queryParameter;
  }

  @override
  set parameters(Map<String, dynamic> parameters) {
    parameters = parameters;
  }

  @override
  // TODO: implement baseURL
  String get baseURL => 'newsapi.org';

  @override
  Future<List<News>> fetchNews() async {
    Uri uri = Uri.https(baseURL, "/v2/everything", parameters);
    final response = await _client.get(uri, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    // List<News> list = parseNewsFrom(response.body); => app freeze for a moment
    // Use compute to isolate to background thread
    var parseNewsFunc = ParseNews().parseObjectFrom;
    return compute(parseNewsFunc, response.body);
  }

  @override
  Future<List<NewsListObject>> fetchNewsListObject() async {
    // TODO: implement fetchNewsListObject
    final response = await _client.get(Uri.parse(baseURL));
    var parseNewsListObject = ParseNewObject().parseObjectFrom;
    return compute(parseNewsListObject, response.body);
  }
}
