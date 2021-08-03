import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/icons/flutter_menu_icons.dart';

import 'package:ipos/screens/iponews.dart';
import 'package:ipos/screens/listedIPOs.dart';
import 'package:ipos/screens/liveIPOs.dart';
import 'package:ipos/screens/newstoupdate.dart';

//import '../getData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Color background;
  late Color foreground;
  late Color accent;
  AppColors colors = AppColors();
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    //  sriesList = _createRandomData();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = colors.accent;
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: Text("IPO Cart"),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(FlutterMenu.union_50, size: 10)),
        actions: [
          IconButton(
              onPressed: () {
                ThemeChanger.of(context)!.changeTheme();
              },
              icon: Icon(Icons.wb_sunny)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsToUpdate(),
                  ),
                );
              },
              icon: Icon(Icons.new_releases_sharp)),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(text: "Live IPOs"),
            Tab(text: "Listed IPOs"),
            Tab(text: "IPO News")
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [LiveIPO(), ListedIPO(), IPONews()],
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: Column(
        children: [
          Row(children: [
            Text("jksdj"),
          ]),
          ListTile(
            leading: Icon(Icons.dark_mode_rounded),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode_rounded),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode_rounded),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode_rounded),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {},
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode_rounded),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {},
            ),
          ),
        ],
      ),
    );
  }
}
