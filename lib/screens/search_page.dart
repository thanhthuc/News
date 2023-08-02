
import 'package:flutter/material.dart';

import '../small_component/row_news_view.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  List<String> list = ["1", "2"].toList();
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
    var resultList = list.firstWhere((element) {
      if (element.contains(query)) {
        return true;
      }
      return false;
    });
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 5,
          itemBuilder: (context, index) {
        return const RowNews();
      }),
      
    );
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