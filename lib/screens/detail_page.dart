
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

// TODO: improvement sliver scroll for list page and detail page, add more list type of grid display
// and more of dynamic height display use intrictsed size
class DetailPageState extends State<DetailPage> {
  var imageURL = "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("By author")),
      body:
      Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          const Text("TitleTitleTitleTitleTitleTitleTitle",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)
          ),
            Row(
              children: const [
                Text("timestamp"),
                Spacer(),
                Text("time to read")
              ]
            ),
            Image.network(imageURL),
            const Text("Description"),
            const Text("ContentContentContentContentContentContentContentContentContentContent")
      ]))
    );
  }
}
