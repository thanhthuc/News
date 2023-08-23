
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/state_management/getx/list_news_get_x.dart';

class MyHomePageWithGetX extends StatefulWidget {

  const MyHomePageWithGetX({super.key});

  @override
  State<StatefulWidget> createState() => MyHomePageWithGetXState();
}

class MyHomePageWithGetXState extends State<MyHomePageWithGetX> {

  @override
  Widget build(BuildContext context) {
    final ListNewsController controller = Get.put(ListNewsController());

    return Text("");
  }
}