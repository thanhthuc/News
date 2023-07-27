import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/screens/screen_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Note: may be need portrait up
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeftMenu(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [IconButton(onPressed: (){
          if (kDebugMode) {
            print("Search start");
          }

        }, icon: const Icon(Icons.search))],
      ),
      body:
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: [
                Text(
                  'All news',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(width: 30),
                Text(
                  'Top trending',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer()
              ],)
            ],
          ),
        ),
    );
  }
}
