
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/state_management/getx/list_news_get_x.dart';
import 'package:flutter/foundation.dart';
import '../../small_component/news_list_view.dart';
import '../../small_component/page_number_action_view.dart';
import '../../small_component/published_dropdown_view.dart';
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
    var newsLisController = Get.put(ListNewsController());
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
                        Tab(child: Text("Tech News")),
                        Tab(child: Text("Top News")),
                        Tab(child: Text("All news"))
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
                                newsLisController.toPreviousPage();
                              },
                              nextCallback: (){
                                newsLisController.toNextPage();
                              },
                              pagesNumCallback: (page){
                                newsLisController.fetchTechListNewsByPage(page);
                              }),
                          Row(children: [
                            const Spacer(),
                            DropdownCustom(dropdownFilterCallback: (filterState) {
                              newsLisController.fetchTechListNewsBySortBy(filterState);
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
    ListNewsController c = Get.find<ListNewsController>();
    c.getTopNews();
    return
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey,
        child:
          Obx(() {
            if (c.listTopNews.isEmpty) {
              return const Center(child: Text("There are something wrong"));
            }
            if (c.listTopNews.isNotEmpty) {
              var list = c.listTopNews;
              return NewsListView(list: list);
            }
            else {
              return const CircularProgressIndicator();
            }
          })
      );
  }

  Widget techListNews(BuildContext context) {
    ListNewsController c = Get.find<ListNewsController>();
    c.getTechNews();
    return
      Expanded(child:
        Obx(() {
          if (c.listTechNews.isEmpty) {
            return const Center(child: Text("There are something wrong"));
          }
          if (c.listTechNews.isNotEmpty) {
            var list = c.listTechNews;
            return NewsListView(list: list);
          }
          else {
            return const CircularProgressIndicator();
          }
        })
      );
  }

  Widget allNews(BuildContext context) {
    // final ListNewsBloc bloc = NewsBlocProvider.of(context);
    // bloc.fetchAllListNews();
    ListNewsController c = Get.find<ListNewsController>();
    c.getAllNews();
    return
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey,
        child: Obx(() {
          if (c.listAllNews.isEmpty) {
            return const Center(child: Text("There are something wrong"));
          }
          if (c.listAllNews.isNotEmpty) {
            var list = c.listAllNews;
            return NewsListView(list: list);
          }
          else {
            return const CircularProgressIndicator();
          }
        }),
      );
  }
}