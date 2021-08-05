import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/getData.dart';
import 'package:ipos/widgets/liveipowidget.dart';

class ListedIPO extends StatefulWidget {
  const ListedIPO({Key? key}) : super(key: key);

  @override
  _ListedIPOState createState() => _ListedIPOState();
}

class _ListedIPOState extends State<ListedIPO> {
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
    // print("printing asses.....${cats.liveIPOlist}");
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
    return Container(
      color: background,
      child: FutureBuilder(
          future: cats.getFromListedIPOFireStore(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Please wait its loading...'));
            } else {
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              else
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: cats.listedIPOList.length,
                    itemBuilder: (context, index) {
                      return listedipowidget(mainText, subText, foreground,
                          cats.listedIPOList, index, context);
                    });
            }
          }),

      // SizedBox(height: 10),
    );
  }
}
