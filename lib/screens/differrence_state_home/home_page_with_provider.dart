
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/news_model.dart';
import '../../small_component/news_list_view.dart';
import '../../small_component/page_number_action_view.dart';
import '../../small_component/published_dropdown_view.dart';
import '../../small_component/top_main_filter_view.dart';
import '../../state_management/provider/provider.dart';
import '../screen_menu.dart';
import '../search_page.dart';
import '../top_trend_page.dart';

class MyHomePageWithProvider extends StatefulWidget {
  const MyHomePageWithProvider({super.key});
  @override
  State<StatefulWidget> createState() => MyHomePageWithProviderState();
}

class MyHomePageWithProviderState extends State<MyHomePageWithProvider> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewsListProvider>(context, listen: false).fetchAllNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (kDebugMode) {
      print("rebuild widget provider");
    }
    var provider = Provider.of<NewsListProvider>(context, listen: false);
    return Scaffold(
      drawer: LeftMenu(callback: (action){
        //
      }),
      appBar: AppBar(
        title: const Text("Home with provider"),
        actions: [IconButton(onPressed: () async {
          var result = await showSearch(
              context: context,
              delegate: CustomSearchDelegate()
          );

        }, icon: const Icon(Icons.search))],
      ),
      body:
      Container(
          color: Colors.grey,
          padding: const EdgeInsets.all(20),
          child:
          Column(
            children: <Widget>[
              TopMainFilterView(allNewsCallback: (){
                provider.fetchAllNews();
              }, topTrendingCallback: () {
                provider.fetchTopHeading();
              }),
              if (provider.isAllNew)
                Expanded(child: Column(
                  children: [
                    PageNumberActionView(
                        prevCallback: (){
                          provider.preCallbackHandle();
                        },
                        nextCallback: (){
                          provider.nextCallbackHandle();
                        },
                        pagesNumCallback: (page){
                          provider.fetchNews(page, provider.sortBy);
                        }),
                    Row(children: [
                      const Spacer(),
                      DropdownCustom(dropdownFilterCallback: (filterState) {
                        provider.fetchNews(provider.currentPage, filterState);
                      },)
                    ]),
                    Container(height: 20),
                    Consumer<NewsListProvider>(builder: (context, value, child) {
                      if (value.isLoading) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      final newsList = value.listNews;
                      return NewsListView(list: newsList);
                    })
                  ],
                )),
              if (!provider.isAllNew)
                TopTrend()
            ]
          )
      ),
    );
  }
}