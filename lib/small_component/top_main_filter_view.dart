
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TopMainFilterView extends StatelessWidget {
  final VoidCallback allNewsCallback;
  final VoidCallback topTrendingCallback;
  const TopMainFilterView({
    super.key,
    required this.allNewsCallback,
    required this.topTrendingCallback}
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        MaterialButton(onPressed: () => allNewsCallback(), child: const Text("All news")),
        MaterialButton(onPressed: () => topTrendingCallback(), child: const Text("Top trending")),
      ],
    );
  }
}