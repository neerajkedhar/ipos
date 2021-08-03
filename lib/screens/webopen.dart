import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webopen extends StatefulWidget {
  Webopen(this.urlString, {Key? key}) : super(key: key);
  String urlString;
  @override
  _WebopenState createState() => _WebopenState();
}

class _WebopenState extends State<Webopen> {
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
          initialUrl: widget.urlString,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewcontroller) {
            _controller = webviewcontroller;
          }),
    );
  }
}
