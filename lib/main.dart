import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/screens/home_page.dart';
import 'package:news/state_management/provider/provider.dart';
import 'package:provider/provider.dart';

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

    // return MaterialApp(
    //   title: 'News',
    //   theme: ThemeData(
    //     primarySwatch: Colors.yellow,
    //   ),
    //   home:
    //   const MyHomePage(title: 'News'),
    // );
    return
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) {
          return NewsListProvider();
        })
      ],
      child:
      MaterialApp(
        title: 'News',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home:
        const MyHomePage(title: 'News'),
      ));
  }
}