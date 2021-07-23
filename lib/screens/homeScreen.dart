import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/screens/listedIPOs.dart';
import 'package:ipos/screens/liveIPOs.dart';

//import '../getData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Color background;
  late Color foreground;
  late Color accent;
  AppColors colors = AppColors();
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    //  sriesList = _createRandomData();
    _controller = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: Text("IPO Cart"),
        actions: [
          IconButton(
              onPressed: () {
                ThemeChanger.of(context)!.changeTheme();
              },
              icon: Icon(Icons.wb_sunny)),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: [Tab(text: "Live IPOs"), Tab(text: "Listed IPOs")],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          LiveIPO(),
          ListedIPO(),
        ],
      ),
    );
  }
}
