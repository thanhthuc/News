
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/state_management/getx/list_news_get_x.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/state_management/bloc_home_news_list/news_home_bloc_provider_statefulWidget.dart';
import '../../model/news_model.dart';
import '../../small_component/news_list_view.dart';
import '../../small_component/page_number_action_view.dart';
import '../../small_component/published_dropdown_view.dart';
import '../../state_management/bloc_home_news_list/news_home_bloc.dart';
import '../other_pages/screen_menu.dart';
import '../search_page/search_page_with_delegate.dart';

class MyHomePageWithGetX extends StatefulWidget {
  const MyHomePageWithGetX({super.key});
  @override
  State<StatefulWidget> createState() => MyHomePageWithGetXState();
}

class MyHomePageWithGetXState extends State<MyHomePageWithGetX> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("rebuild widget getX");
    }
    var newsLisController = ListNewsController();
    return
      DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
              drawer: LeftMenu(callback: (action){
                //
              }),
              appBar:
              AppBar(
                  elevation: 0,
                  title: const Text("Home with provider"),
                  actions: [IconButton(onPressed: () async {
                    var result = await showSearch(
                        context: context,
                        delegate: CustomSearchDelegate()
                    );
                  }, icon: const Icon(Icons.search))],
                  bottom:
                  TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          1.0,
                        ),
                        color: Colors.grey,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      onTap: (index) {
                        // Do nothing
                      },
                      tabs: const [
                        Tab(
                            child: Text("Tech News")
                        ),
                        Tab(
                            child: Text("Top News")
                        ),
                        Tab(
                            child: Text("All news")
                        )
                      ])
              ),
              body:
              TabBarView(
                children: [
                  Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.all(20),
                      child:
                      Column(
                        children: [
                          PageNumberActionView(
                              prevCallback: (){
                                bloc.toPreviousPage();
                              },
                              nextCallback: (){
                                bloc.toNextPage();
                              },
                              pagesNumCallback: (page){
                                bloc.fetchTechListNewsByPage(page);
                              }),
                          Row(children: [
                            const Spacer(),
                            DropdownCustom(dropdownFilterCallback: (filterState) {
                              bloc.fetchTechListNewsBySortBy(filterState);
                            },)
                          ]),
                          techListNews(context),
                        ],
                      )
                  ),
                  topListNews(context),
                  allNews(context)
                ],
              )
          )
      );
  }

  Widget topListNews(BuildContext context) {
    // final ListNewsBloc bloc = NewsBlocProvider.of(context);
    // bloc.fetchTopListNews();
    return
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey,
        child: StreamBuilder<List<News>>(
            stream: bloc.topListNewsStream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("There are something wrong"));
              }
              if (snapshot.hasData) {
                var list = snapshot.data ?? [];
                return NewsListView(list: list);
              }
              else {
                return const CircularProgressIndicator();
              }
            }),
      );
  }

  Widget techListNews(BuildContext context) {
    // final ListNewsBloc bloc = NewsBlocProvider.of(context);
    // bloc.fetchTechListNews();
    return
      Expanded(child: StreamBuilder<List<News>>(
          stream: bloc.listTechNewsStream.stream,
          builder: (context, snapshot) {
            if (kDebugMode) {
              print("call stream builder again");
            }
            if (snapshot.hasError) {
              return const Center(child: Text("There are something wrong"));
            }
            if (snapshot.hasData) {
              var list = snapshot.data ?? [];
              return NewsListView(list: list);
            }
            else {
              return const CircularProgressIndicator();
            }
          }));
  }

  Widget allNews(BuildContext context) {
    // final ListNewsBloc bloc = NewsBlocProvider.of(context);
    // bloc.fetchAllListNews();
    return
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey,
        child: StreamBuilder<List<News>>(
            stream: bloc.allListNewsStream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("There are something wrong"));
              }
              if (snapshot.hasData) {
                var list = snapshot.data ?? [];
                return NewsListView(list: list);
              }
              else {
                return const CircularProgressIndicator();
              }
            }),
      );
  }
}