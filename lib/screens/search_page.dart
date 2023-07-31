
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Search page"), actions: [

      ],),
      body: Container(
          padding: const EdgeInsets.all(5),
          child: Column(children: [

      ]
      )
      ),
    );
  }
}