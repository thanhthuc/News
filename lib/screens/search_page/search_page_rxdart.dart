
import 'package:flutter/material.dart';
import 'package:news/small_component/news_list_view.dart';
import 'package:news/state_management/bloc_search/search_bloc.dart';
import '../../model/news_model.dart';
import '../../state_management/bloc_search/search_bloc_provider.dart';

class SearchPageResult extends StatefulWidget {
  const SearchPageResult({super.key});
  @override
  State<StatefulWidget> createState() => SearchPageResultState();
}

class SearchPageResultState extends State<SearchPageResult> {

  @override
  Widget build(BuildContext context) {
    final bloc = SearchBlocProvider.of<SearchBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('News Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search ...',
              ),
              // 2
              onChanged: bloc.searchQuerySink.add,
            ),
          ),
          Expanded(
            // 3
            child: _buildResults(bloc),
          )
        ],
      ),
    );
  }

  Widget _buildResults(SearchBloc bloc) {
    return StreamBuilder<List<News>>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("No search result"));
          } else if (snapshot.hasData) {
            return NewsListView(list: snapshot.data!);
          } else {
            return Container();
          }
        }
    );
  }
}