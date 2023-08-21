
// Difference between abstract vs interface
// Keyword: implement & extend
// Multi inherited
// https://developermemos.com/posts/dart-abstract-classes-interfaces

// TODO: Add more API: https://www.kodeco.com/31973428-getting-started-with-the-bloc-pattern#toc-anchor-001
// TODO: use this api: https://github.com/MohamadSobhy/News-App-Hacker-News-Api---Flutter-
// TODO: https://github.com/HackerNews/API
// TODO:Add a page with github trend

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:news/model/news_model.dart';
import 'package:http/http.dart';
import 'package:news/model/object_model.dart';
import 'package:news/small_component/published_dropdown_view.dart';

abstract class BaseAPI {
  String get baseURL;
  String get apiKey;
  late Map<String, dynamic> parameters;
  Future<List<News>> fetchNews();
  Future<List<News>> fetchNewsWith(int pageSize, DropdownFilterState sortBy);
  Future<List<News>> fetchTopNews();
  Future<List<News>> fetchNewsWithParameter(Map<String, dynamic> parameters);
}

abstract class Parse<T> {
  List<T> parseObjectFrom(String jsonResponseBody);
}

class ParseNews implements Parse {
  @override
  List<News> parseObjectFrom(String jsonResponseBody) {
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

  // 7a54e7a933484afd9b32f60e79db993e: test
  // 8ccb67aaefd4475ba20a6bb2ef79a35d: dev
  @override
  String apiKey = "7a54e7a933484afd9b32f60e79db993e";
  // GET https://newsapi.org/v2/everything?q=Apple&from=2023-08-03&sortBy=popularity&apiKey=API_KEY
  // String get baseURL => "https://newsapi.org/v2/everything?q=Apple&from=2023-08-03&sortBy=popularity&apiKey=$apiKey";

  @override
  // TODO: implement parameters
  Map<String, dynamic> get parameters {
    var queryParameter = {
      "q":"Apple",
      // "from":2023-08-05,
      "pageSize":"5",
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
  Future<List<News>> fetchNewsWithParameter(Map<String, dynamic> parameters) async {
    // TODO: implement fetchNewsWithParameter
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
  Future<List<News>> fetchNewsWith(int pageSize, DropdownFilterState sortBy) async {
    Map<String, dynamic> parameters = {
      "q": "Apple",
      // "from":2023-08-05,
      "pageSize": "$pageSize",
      "sortBy": sortBy.name,
      "apiKey": apiKey
    };

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
  Future<List<News>> fetchTopNews() async {
    // TODO: implement fetchTopNews
    Map<String, dynamic> parameters = {
      // "q": "Apple",
      // "from":2023-08-05,
      "country":"us",
      "apiKey": apiKey
    };

    Uri uri = Uri.https(baseURL, "/v2/top-headlines", parameters);

    final response = await _client.get(uri, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    // List<News> list = parseNewsFrom(response.body); => app freeze for a moment
    // Use compute to isolate to background thread
    var parseNewsFunc = ParseNews().parseObjectFrom;
    return compute(parseNewsFunc, response.body);
  }
}
