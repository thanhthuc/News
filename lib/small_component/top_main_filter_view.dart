
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TopMainFilterView extends StatelessWidget {
  const TopMainFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        MaterialButton(onPressed: (){
          if (kDebugMode) {
            print("filter all news");
          }

        }, child: const Text("All news")),
        MaterialButton(onPressed: (){
          if (kDebugMode) {
            print("filter top trending");
          }
        }, child: const Text("Top trending")),
      ],
    );
  }
}