
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/small_component/news_list_view.dart';
import 'package:news/state_management/bloc_home_news_list/news_home_bloc.dart';
import 'package:news/state_management/bloc_home_news_list/news_home_bloc_provider_statefulWidget.dart';
import 'package:news/state_management/bloc_login/login_bloc.dart';
import 'package:news/state_management/bloc_login/login_bloc_provider.dart';
import 'package:news/state_management/bloc_search/search_bloc.dart';
import '../../model/news_model.dart';
import '../../state_management/bloc_search/search_bloc_provider.dart';
import '../login/login_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<StatefulWidget> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    // final bloc = SearchBlocProvider.of<SearchBloc>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.of(context).pop();
              }),
          title: const Text('Account')
      ),
      body:
      Padding(
          padding: const EdgeInsets.all(16),
          child: NewsBlocProvider(
              bloc: ListNewsBloc(),
              child:
              const Center(
                  child: Text("Account page"),
              )
          )
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