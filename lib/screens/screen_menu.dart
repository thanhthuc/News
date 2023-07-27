

// This is stateful widget
import 'package:flutter/material.dart';

class LeftMenu extends StatefulWidget {
  const LeftMenu({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LeftMenuState();
  }
}

class LeftMenuState extends State<LeftMenu> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(child: ListView(children: [
       DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
          child: Column(children: [
            Image.asset("assets/images/news.jpg"),
            Container(height: 20),
            const Flexible(child: Text("News world"))
          ],)
      ),
      Column(
        children: [
          ListTile(
              leading: Image.asset("assets/images/home_menu.png", width: 25, height: 25,),
              title: const Text("Home")),
          ListTile(
              leading: Image.asset("assets/images/bookmark_menu.png", width: 25, height: 25,),
              title: const Text("Bookmark")),
          ListTile(
            leading: Image.asset("assets/images/theme_menu.png", width: 25, height: 25,),
            title: const Text("Theme"),
            trailing: Switch(value: light, onChanged: (onChange) {
              setState(() {
                light = !light;
              });
          }))
        ],
      )
    ],));
  }
}
