import 'package:flutter/foundation.dart';import 'package:flutter/material.dart';import 'package:news/state_management/bloc_home_news_list/news_home_bloc_provider_statefulWidget.dart';import '../../model/news_model.dart';import '../../small_component/news_list_view.dart';import '../../small_component/page_number_action_view.dart';import '../../small_component/published_dropdown_view.dart';import '../../state_management/bloc_home_news_list/news_home_bloc.dart';import '../other_pages/screen_menu.dart';import '../search_page/search_page_with_delegate.dart';class MyHomePageWithBloc extends StatefulWidget {  const MyHomePageWithBloc({super.key});  @override  State<StatefulWidget> createState() => MyHomePageWithBlocState();}class MyHomePageWithBlocState extends State<MyHomePageWithBloc> with TickerProviderStateMixin {  var allNewsStream;  var techNewsStream;  var topNewsStream;  @override  void initState() {    super.initState();    if (kDebugMode) {      print("Init state");    }  }  @override  void dispose() {    super.dispose();    if (kDebugMode) {      print("dispose bloc");    }  }  @override  Widget build(BuildContext context) {    if (kDebugMode) {      print("rebuild widget bloc");    }    final ListNewsBloc bloc = NewsBlocProvider.of(context);    return      DefaultTabController(          initialIndex: 0,          length: 3,          child: Scaffold(            drawer: LeftMenu(callback: (action){              //            }),            appBar:            AppBar(                elevation: 0,              title: const Text("Home with provider"),              actions: [IconButton(onPressed: () async {                var result = await showSearch(                    context: context,                    delegate: CustomSearchDelegate()                );              }, icon: const Icon(Icons.search))],              bottom:              TabBar(                  indicator: BoxDecoration(                    borderRadius: BorderRadius.circular(                      1.0,                    ),                    color: Colors.grey,                  ),                  labelColor: Colors.white,                  unselectedLabelColor: Colors.black,                onTap: (index) {                    // Do nothing                  switch (index) {                    case 0:                      bloc.fetchTechListNews();                      break;                    case 1:                      bloc.fetchTopListNews();                      break;                    case 2:                      bloc.fetchAllListNews();                      break;                  }                },                  tabs: const [                    Tab(                    child: Text("Tech News")                ),                    Tab(                    child: Text("Top News")                ),                    Tab(                        child: Text("All news")                    )              ])            ),            body:            TabBarView(              children: [                Container(                    color: Colors.grey,                    padding: const EdgeInsets.all(20),                    child:                    Column(                      children: [                        PageNumberActionView(                            prevCallback: (){                              bloc.toPreviousPage();                            },                            nextCallback: (){                              bloc.toNextPage();                            },                            pagesNumCallback: (page){                              bloc.fetchTechListNewsByPage(page);                            }),                        Row(children: [                          const Spacer(),                          DropdownCustom(dropdownFilterCallback: (filterState) {                            bloc.fetchTechListNewsBySortBy(filterState);                          },)                        ]),                        techListNews(context),                      ],                    )                ),                topListNews(context),                allNews(context)              ],            )          )      );  }  Widget techListNews(BuildContext context) {    final ListNewsBloc bloc = NewsBlocProvider.of(context);    techNewsStream = bloc.listTechNewsStream.stream;    bloc.fetchTechListNews();    return      Expanded(child: StreamBuilder<List<News>>(          stream: techNewsStream,          builder: (context, snapshot) {            if (kDebugMode) {              print("call stream builder techListNews again");            }            if (snapshot.hasError) {              return const Center(child: Text("There are something wrong"));            }            if (snapshot.hasData) {              var list = snapshot.data ?? [];              return NewsListView(list: list);            }            else {              return const Center(child: CircularProgressIndicator(),);            }          }));  }  Widget topListNews(BuildContext context) {    final ListNewsBloc bloc = NewsBlocProvider.of(context);    topNewsStream = bloc.topListNewsStream.stream;    return      Container(        padding: const EdgeInsets.all(20),        color: Colors.grey,        child: StreamBuilder<List<News>>(            stream: topNewsStream,            builder: (context, snapshot) {              if (kDebugMode) {                print("call stream builder topListNews again");              }              if (snapshot.hasError) {                return const Center(child: Text("There are something wrong"));              }              if (snapshot.hasData) {                var list = snapshot.data ?? [];                return NewsListView(list: list);              }              else {                return const Center(child: CircularProgressIndicator());              }            }),      );  }  Widget allNews(BuildContext context) {    final ListNewsBloc bloc = NewsBlocProvider.of(context);    allNewsStream = bloc.allListNewsStream.stream;    print("call all ---");    return      Container(        padding: const EdgeInsets.all(20),        color: Colors.grey,        child: StreamBuilder<List<News>>(            stream: allNewsStream,            builder: (context, snapshot) {              if (kDebugMode) {                print("call stream builder allNews again");              }              if (snapshot.hasError) {                return const Center(child: Text("There are something wrong"));              }              if (snapshot.hasData) {                var list = snapshot.data ?? [];                return NewsListView(list: list);              }              else {                return const Center(child: CircularProgressIndicator(),);              }            }),      );  }  @override  // TODO: implement wantKeepAlive  bool get wantKeepAlive => true;}