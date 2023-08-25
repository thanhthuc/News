
import 'package:flutter/foundation.dart';

// News api key: 8ccb67aaefd4475ba20a6bb2ef79a35d

class News {
  String? title;
  String? content;
  String? url;
  String? description;
  String? publishedAt;
  String? imageURL;
  DateTime? dateTime;
  String? timeToRead;
  String? timestamp;
  News ({
    required this.title,
    required this.content,
    required this.url,
    required this.description,
    required this.publishedAt,
    required this.imageURL,
    required this.dateTime,
    required this.timeToRead,
    required this.timestamp
  }) {
    if (kDebugMode) {
      //print("init News Model content: ${this.content}");
    }
  }

  factory News.fromJson(Map<String?, dynamic> json) {
    return News(
        title: json["title"] as String?,
        content: json["content"] as String?,
        url: json["url"] as String?,
        description: json["description"] as String?,
        publishedAt: json["publishedAt"] as String?,
        imageURL: json["urlToImage"] as String?,
        dateTime: json["DateTime"] as DateTime?,
        timeToRead: json["timeToRead"] as String?,
        timestamp: json["timestamp"] as String?);
  }
}