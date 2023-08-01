
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
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 3,
          itemBuilder: (context, index) {
        return const RowNews();
      }),
      
    );
  }

  List<String> listSuggest = ["Flutter", "US", "Business", "Technology", "World", "Cars", "Homes", "Flutter",
    "US", "Business", "Technology", "World", "Cars", "Homes"];
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return
      Container(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: listSuggest.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 20
          ),
          itemBuilder: (context, index){
            var item = listSuggest[index];
            return Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    color: Colors.black12),
                child: Text(item)
            );
          })
      );
  }
  
}

// class CustomGridDelegate extends GridDelegate {
//
// }