
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("By author")),
      body:
      Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: const [
          Text("Title",
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 30, fontWeight: FontWeight.bold)),
  
      ]))
    );
  }
}
