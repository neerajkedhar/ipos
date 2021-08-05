import 'package:flutter/material.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/getData.dart';
import 'package:ipos/widgets/newstoUpdateWidget.dart';

class NewsToUpdate extends StatefulWidget {
  const NewsToUpdate({Key? key}) : super(key: key);

  @override
  _NewsToUpdateState createState() => _NewsToUpdateState();
}

class _NewsToUpdateState extends State<NewsToUpdate> {
  late Color background;
  late Color foreground;
  late Color accent;
  late Color mainText;
  late Color subText;
  AppColors colors = AppColors();
  GetNews cats = new GetNews();
  SetNews setnews = new SetNews();
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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: FutureBuilder(
                    future: cats.getHttp(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Text('Please wait its loading...'));
                      } else {
                        if (snapshot.hasError)
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        else
                          return ListView.builder(
                              itemCount: cats.newsList.length,
                              itemBuilder: (context, index) {
                                return newsToUpdateWidget(mainText, subText,
                                    foreground, cats.newsList, index, context);
                              });
                      }
                    })),
          )),
    );
  }
}
