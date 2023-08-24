

// This is stateful widget
import 'package:flutter/material.dart';

enum LeftMenuAction {
  home,
  bookmark,
}

class LeftMenu extends StatefulWidget {
  final Function(LeftMenuAction) callback;
  const LeftMenu({super.key, required this.callback});

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
    return Drawer(
        child: ListView(children: [
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
          GestureDetector(
            onTap: (){
              widget.callback(LeftMenuAction.home);
              // Navigator.pop(context);
            },
            child: ListTile(
              leading: Image.asset("assets/images/home_menu.png", width: 25, height: 25,),
              title: const Text("Home")
            )
          ),
          GestureDetector(
            onTap: (){
              widget.callback(LeftMenuAction.bookmark);
              Navigator.pop(context);
            },
            child: ListTile(
                leading: Image.asset("assets/images/bookmark_menu.png", width: 25, height: 25,),
                title: const Text("Bookmark")
            )
          ),
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
