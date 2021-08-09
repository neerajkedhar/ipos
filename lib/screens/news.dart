import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/getData.dart';
import 'package:ipos/widgets/newswidget.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Color background;
  late Color foreground;
  late Color accent;
  late Color mainText;
  late Color subText;
  AppColors colors = AppColors();
  GetNews cats = new GetNews();
  SetNews setnews = new SetNews();

  var newsList;
  Future getHttp() async {
    try {
      var moneyresponse = await Dio().get(
          'https://newsapi.org/v2/everything?q=ipos%20news%20in%20india&sortBy=publishedAt&apiKey=746a076d37f241f2acf59c8d6920ed75');
      var mcnewsData = moneyresponse.data['articles'];
      newsList = mcnewsData;
      print(newsList);
    } catch (e) {
      print(e);
    }
    // getFromListedIPOFireStore();
  }

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

    return Container(
      color: background,
      child: FutureBuilder(
          future: getHttp(),
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
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return newsWidget(mainText, subText, foreground, newsList,
                          index, context);
                    });
            }
          }),
    );
  }
}
