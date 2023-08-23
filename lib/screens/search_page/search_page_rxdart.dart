
import 'package:flutter/material.dart';

class SearchPageResult extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SearchPageResultState();
}

class SearchPageResultState extends State<SearchPageResult> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(builder: (context, snapshot) {
      return Text("data");
    });
  }
}