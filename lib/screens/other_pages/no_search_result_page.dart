
import 'package:flutter/material.dart';

class NoSearchResult extends StatelessWidget {

  const NoSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: const Center(child: Text("No Search result")),
    );
  }
}
