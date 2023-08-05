
import 'package:flutter/material.dart';
import 'package:news/model/news_model.dart';
import 'package:news/small_component/news_list_view.dart';

import '../small_component/row_news_view.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  List<News> searchList = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: const Icon(Icons.close), onPressed: () {
      query = '';
    })];
  }

  //
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {
      close(context, '');
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<News> resultList = searchList.where((element) {
      bool searchInTitle = element.title!.contains(query);
      bool searchInContent = element.content!.contains(query);
      if (searchInTitle || searchInContent) {
        return true;
      }
      return false;
    }).toList();

    print("query: $query");
    print("result list: $resultList");
    var result = [
      News(title: "title",
          content: "content",
          url: "url",
          description: "description",
          publishedAt: "publishedAt",
          imageURL: null,
          dateTime: DateTime.now(),
          timeToRead: "timeToRead",
          timestamp: "timestamp")];
    return NewsListView(list: result);
  }

  List<String> listSuggest = ["Flutter", "US", "Business", "Technology", "World", "Cars", "Homes", "Flutter",
    "US", "Business", "Technology", "World", "Cars", "Homes", "World", "Cars", "Homes"];
  @override
  Widget buildSuggestions(BuildContext context) {

    return
      Scrollable(
          viewportBuilder: (context, index) {
        return 
          Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              spacing: 8,
              runSpacing: 10,
              children: listSuggest.map((item) {
                return Container(
                  // height: 10,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.black12),
                    child: Text(item)
                );
              }).toList()),);
      });
  }
  
}

// class CustomGridDelegate extends GridDelegate {
//
// }