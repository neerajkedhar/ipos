import 'package:flutter/material.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webopen extends StatefulWidget {
  Webopen(this.urlString, {Key? key}) : super(key: key);
  String urlString;
  @override
  _WebopenState createState() => _WebopenState();
}

class _WebopenState extends State<Webopen> {
  late Color background;
  late Color foreground;
  late Color accent;
  late Color mainText;
  late Color subText;
  AppColors colors = AppColors();
  WebViewController? _controller;
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainText,
            )),
        backgroundColor: background,
        elevation: 0,
        title: Text(
          "IPO Market",
          style: TextStyle(color: mainText),
        ),
      ),
      body: WebView(
          initialUrl: widget.urlString,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewcontroller) {
            _controller = webviewcontroller;
          }),
    );
  }
}
