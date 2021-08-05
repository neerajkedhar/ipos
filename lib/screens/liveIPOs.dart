import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/data/uicolors.dart';

import 'package:ipos/getData.dart';
import 'package:ipos/widgets/liveipowidget.dart';

class LiveIPO extends StatefulWidget {
  const LiveIPO({Key? key}) : super(key: key);

  @override
  _LiveIPOState createState() => _LiveIPOState();
}

class _LiveIPOState extends State<LiveIPO> {
  late Color background;
  late Color foreground;
  late Color accent;
  late Color mainText;
  late Color subText;
  AppColors colors = AppColors();
  CategoryServices cats = new CategoryServices();
  var firestoreDb = FirebaseFirestore.instance.collection("ipos").snapshots();
  @override
  Widget build(BuildContext context) {
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = Theme.of(context).brightness == Brightness.dark
        ? colors.accent
        : colors.accentL;
    mainText = Theme.of(context).brightness == Brightness.dark
        ? colors.darkmaintext
        : colors.litemaintext;
    subText = Theme.of(context).brightness == Brightness.dark
        ? colors.darksubtext
        : colors.litesubtext;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Live IPOs",
                    style: TextStyle(
                        fontSize: 12,
                        color: accent,
                        fontWeight: FontWeight.bold)),
              ),
              FutureBuilder(
                  future: cats.getFromLiveIPOFireStore(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Please wait its loading...'));
                    } else {
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cats.liveIPOlist.length,
                            itemBuilder: (context, index) {
                              return liveipowidget(mainText, subText,
                                  foreground, cats.liveIPOlist, index, context);
                            });
                    }
                  }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Upcoming IPOs",
                    style: TextStyle(
                        fontSize: 12,
                        color: accent,
                        fontWeight: FontWeight.bold)),
              ),
              FutureBuilder(
                  future: cats.getFromUpcomingIPOFireStore(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Please wait its loading...'));
                    } else {
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cats.upcomingIPOList.length,
                            itemBuilder: (context, index) {
                              return upcomingipowidget(
                                  mainText,
                                  subText,
                                  foreground,
                                  cats.upcomingIPOList,
                                  index,
                                  context);
                            });
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
