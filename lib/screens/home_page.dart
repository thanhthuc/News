import 'package:flutter/foundation.dart';import 'package:flutter/material.dart';import 'package:news/screens/no_search_result_page.dart';import 'package:news/screens/screen_menu.dart';import 'package:news/small_component/page_number_action_view.dart';import 'package:news/small_component/row_news_view.dart';import '../small_component/published_dropdown_view.dart';import '../small_component/top_main_filter_view.dart';class MyHomePage extends StatefulWidget {  const MyHomePage({super.key, required this.title});  final String title;  @override  State<MyHomePage> createState() => _MyHomePageState();}class _MyHomePageState extends State<MyHomePage> {  void topTrend() {    if (kDebugMode) {      print("top trend");    }  }  void allNews() {    if (kDebugMode) {      print("all news");    }  }  void prev() {    if (kDebugMode) {      print("prev");    }  }  void next() {    if (kDebugMode) {      print("next");    }  }  void pagesNum(int page) {    if (kDebugMode) {      print("page num: $page");    }  }  @override  Widget build(BuildContext context) {    return Scaffold(      drawer: const LeftMenu(),      appBar: AppBar(        title: Text(widget.title),        actions: [IconButton(onPressed: (){          if (kDebugMode) {            print("Search start");          }          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const NoSearchResult()));        }, icon: const Icon(Icons.search))],      ),      body: Container(          color: Colors.grey,          padding: const EdgeInsets.all(20),          child: Column(            children: <Widget>[              TopMainFilterView(allNewsCallback: allNews, topTrendingCallback: topTrend),              PageNumberActionView(prevCallback: prev, nextCallback: next, pagesNumCallback: pagesNum),              Row(children: const [                Spacer(),                DropdownCustom()              ]),              Container(height: 20),              Expanded(                  flex: 1,                  child: ListView.separated(                      scrollDirection: Axis.vertical,                      itemCount: 20,                      itemBuilder: (context, index) {                        return GestureDetector(                          child: const RowNews(),                          onTap: (){                            if (kDebugMode) {                              print("index: $index");                            }                          },                        );                      }, separatorBuilder: (BuildContext context, int index) {                        return Container(height: 8,);                  },)              )            ],      )),    );  }}