import 'package:flutter/material.dart';
import 'package:ipos/data/uicolors.dart';

class ListedIPO extends StatefulWidget {
  const ListedIPO({Key? key}) : super(key: key);

  @override
  _ListedIPOState createState() => _ListedIPOState();
}

class _ListedIPOState extends State<ListedIPO> {
  late Color background;
  late Color foreground;
  late Color accent;
  AppColors colors = AppColors();
  @override
  Widget build(BuildContext context) {
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = colors.accent;
    return Container(
      color: background,
    );
  }
}
