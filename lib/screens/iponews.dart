import 'package:flutter/material.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/getData.dart';
import 'package:ipos/widgets/newswidget.dart';

class IPONews extends StatefulWidget {
  const IPONews({Key? key}) : super(key: key);

  @override
  _IPONewsState createState() => _IPONewsState();
}

class _IPONewsState extends State<IPONews> {
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
    accent = colors.accent;
    mainText = Theme.of(context).brightness == Brightness.dark
        ? colors.darkmaintext
        : colors.litemaintext;
    subText = Theme.of(context).brightness == Brightness.dark
        ? colors.darksubtext
        : colors.litesubtext;
    return Container(
      color: background,
      child: FutureBuilder(
          future: cats.getFromIPONewsFireStore(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Please wait its loading...'));
            } else {
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              else
                return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cats.iposNewsList.length,
                    itemBuilder: (context, index) {
                      return newsWidget(mainText, subText, foreground,
                          cats.iposNewsList, index, context);
                    });
            }
          }),
    );
  }
}
