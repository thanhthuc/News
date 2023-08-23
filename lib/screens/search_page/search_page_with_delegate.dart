
import 'package:flutter/material.dart';
import 'package:news/api_client/api_client.dart';
import 'package:news/model/news_model.dart';
import 'package:news/small_component/news_list_view.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  List<News> searchList = [];
  final APIClient _apiClient = APIClient();
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: const Icon(Icons.close), onPressed: () {
      query = '';
      showSuggestions(context);
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
    // Call api
    var queryParameter = {
      "q":query,
      // "from":2023-08-05,
      // "pageSize":5,
      "sortBy":"popularity",
      "apiKey":_apiClient.apiKey
    };

    return Container(
      padding: const EdgeInsets.all(20),
      child:
      FutureBuilder<List<News>>(
        future: _apiClient.fetchNewsWithParameter(queryParameter),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Has an error, please reset search"));
          } else if (snapshot.hasData) {
            return NewsListView(list: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  List<String> listSuggest = ["Flutter", "US", "Business", "Technology", "World", "Cars", "Homes", "Swift",
    "iOS", "Android", "AI", "Peace", "Asia", "Japan", "China", "Automations", "Homes"];
  @override
  Widget buildSuggestions(BuildContext context) {
    return Scrollable(
        viewportBuilder: (context, index) {
        return
          Padding(
            padding: const EdgeInsets.all(5),
            child:
            Wrap(
              spacing: 10,
              runSpacing: 3,
              children: listSuggest.map((item) {
                return
                  ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        query = item;
                      },
                      child: Text(item),
                    ),
                  );
              }).toList()));
      });
  }
  
}

// class CustomGridDelegate extends GridDelegate {
//
// }