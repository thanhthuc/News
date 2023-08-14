
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/state_management/stream/stream.dart';
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


class MyHomePageWithStream extends StatefulWidget {
  const MyHomePageWithStream({super.key});
  @override
  State<StatefulWidget> createState() => MyHomePageWithStreamState();
}

class MyHomePageWithStreamState extends State<MyHomePageWithStream> {
  var streamModel = NewsListStreamModel();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamModel.streamController?.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch data from stream
    streamModel.getList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (kDebugMode) {
      print("rebuild widget provider");
    }
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
                  streamModel.getList();
                }, topTrendingCallback: () {
                  streamModel.fetchTopHeading();
                }),
                StreamBuilder<NewsPageState>(
                  stream: streamModel.streamController?.stream,
                    builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  List<News> newsList = snapshot.data?.list ?? [];
                  if (snapshot.data?.isAllNew ?? false) {
                    return Expanded(child: Column(
                      children: [
                        PageNumberActionView(
                            prevCallback: (){
                              streamModel.preCallbackHandle();
                            },
                            nextCallback: (){
                              streamModel.nextCallbackHandle();
                            },
                            pagesNumCallback: (page){
                              streamModel.fetchNews(page, streamModel.sortBy);
                            }),
                        Row(children: [
                          const Spacer(),
                          DropdownCustom(dropdownFilterCallback: (filterState) {
                            streamModel.fetchNews(streamModel.currentPage, filterState);
                          },)
                        ]),
                        Container(height: 20),
                        NewsListView(list: newsList)
                      ],
                    ));
                  }
                  else if (!(snapshot.data?.isAllNew ?? false)) {
                    return TopTrend();
                  }
                  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
              ]
          )
      ),
    );
  }
}