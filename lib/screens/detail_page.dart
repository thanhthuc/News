
import 'package:flutter/material.dart';

import '../model/news_model.dart';

class DetailPage extends StatefulWidget {
  final News news;
  const DetailPage({super.key, required this.news});
  @override
  State<StatefulWidget> createState() => DetailPageState();
}

// TODO: improvement sliver scroll for list page and detail page, add more list type of grid display
// and more of dynamic height display use intrictsed size
class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("By author")),
      body:
      Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.news.title ?? "",
              style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)
          ),
            Row(
              children: [
                Text(widget.news.timestamp ?? ""),
                const Spacer(),
                Text(widget.news.timeToRead ?? "")
              ]
            ),
                FadeInImage(placeholder: const AssetImage("assets/images/news.jpg"), image: NetworkImage(widget.news.imageURL ?? "")),
                Text(widget.news.description ?? ""),
                Text(widget.news.content ?? "")
      ]))
    );
  }
}
