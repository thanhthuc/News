import 'package:flutter/material.dart';class RowNews extends StatefulWidget {  const RowNews({super.key});  @override  State<StatefulWidget> createState() => RowNewState();}class RowNewState extends State<RowNews> {  late String title;  late String timeToRead;  late String timestamp;  late String imageURL;  @override  void initState() {    // TODO: implement initState    super.initState();    title = "Init title" * 10;    timeToRead = "Init time to read sssssssss";    timestamp = "Init timestamp sssssss";    imageURL = "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";  }  @override  void didChangeDependencies() {    // TODO: implement didChangeDependencies    super.didChangeDependencies();  }  @override  void didUpdateWidget(covariant RowNews oldWidget) {    // TODO: implement didUpdateWidget    super.didUpdateWidget(oldWidget);  }  @override  Widget build(BuildContext context) {    // TODO: implement build    return      Stack(        children: [          Positioned(right: 0, bottom: 0, child: Container(width: 50, height: 50, color: Colors.yellow,)),          Positioned(left: 0, top: 0, child: Container(width: 50, height: 50, color: Colors.yellow,)),          Container(            color: Colors.white,            margin: const EdgeInsets.all(5),            child:              Row(                crossAxisAlignment: CrossAxisAlignment.center,                children: [                  Expanded(                      flex: 1,                      child: SizedBox(                        width: 100,                        height: 100,                        child: Image.network(imageURL),                      )                  ),                  Expanded(                      flex: 2,                      child: Column(                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          crossAxisAlignment: CrossAxisAlignment.start,                          children: [                            Row(children: [                              const Spacer(),                              Expanded(flex: 15,                                  child: Text(title)                              )                            ]),                            Container(height: 5),                            Row(children: [                              const Spacer(),                              IconButton(icon: const Icon(Icons.timelapse), onPressed: () {                              }),                              Container(width: 5),                              Expanded( flex: 5, child: Text(timeToRead))                            ]),                            Container(height: 5),                            Row(children: [                              const Spacer(),                              Container(width: 5),                              IconButton(icon: const Icon(Icons.link), onPressed: () {                              }),                              Expanded( flex: 5, child: Text(timestamp))                            ]),                          ]                      ))                ]            ),          )      ],);  }}