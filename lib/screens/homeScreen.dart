import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/icons/flutter_menu_icons.dart';

import 'package:ipos/screens/iponews.dart';
import 'package:ipos/screens/listedIPOs.dart';
import 'package:ipos/screens/liveIPOs.dart';
import 'package:ipos/screens/newstoupdate.dart';
import 'package:ipos/screens/webopen.dart';

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
  late bool themeNow;
  late Color mainText;
  late Color subText;
  @override
  void initState() {
    super.initState();
    //  sriesList = _createRandomData();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    themeNow = Theme.of(context).brightness == Brightness.dark ? true : false;
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = colors.accent;
    mainText = Theme.of(context).brightness == Brightness.dark
        ? colors.darkmaintext
        : colors.litemaintext;
    subText = Theme.of(context).brightness == Brightness.dark
        ? colors.darksubtext
        : colors.litesubtext;
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: Text(
          "IPO Market",
          style: TextStyle(color: mainText),
        ),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              FlutterMenu.union_50,
              size: 10,
              color: mainText,
            )),
        actions: [
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
          labelColor: accent,
          indicatorColor: accent,
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
      child: Container(
        color: background,
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(children: [
                  SizedBox(height: 80),
                  Image.asset(
                    "lib/assets/download.png",
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "IPO Market",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            ListTile(
              leading: themeNow
                  ? Icon(Icons.dark_mode_rounded)
                  : Icon(Icons.wb_sunny_rounded),
              title: Text("Dark Mode"),
              trailing: Switch(
                value: themeNow,
                onChanged: (bool value) {
                  ThemeChanger.of(context)!.changeTheme();
                  themeNow = value;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_rounded),
              title: Text("Privacy Policy"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Webopen(
                          "https://kedhar-app-development-studios.github.io/Privacy-Policy/")),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.report_rounded),
              title: Text("Desclaimer"),
            ),
            ListTile(
              leading: Icon(Icons.feedback_rounded),
              title: Text("Feedback"),
            ),
            ListTile(
              leading: Icon(Icons.star_rounded),
              title: Text("Rate Us"),
            ),
            ListTile(
              leading: Icon(Icons.ios_share_rounded),
              title: Text("Share"),
            ),
          ],
        ),
      ),
    );
  }
}
